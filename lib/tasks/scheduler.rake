task :checkForExecutions => :environment do

  puts 'I am going to check the queue for executions'

  @sqs = Aws::Sqs.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)
  @queue = @sqs.queue(PRESCHEDULING_QUEUE, false)
  @msg = @queue.receive

  puts 'I just received the message:'
  puts @msg

  @parts = @msg.to_s.split(':')

  if @parts[0]== PROCESS_EXECUTION_MSG

    @execution = Execution.find(@parts[1])

    #primero debo crear un nuevo cluster
    puts 'I will create a new cluster'
    @cluster = Cluster.new
    @cluster.user_id = @execution.user_id
    @cluster.name = 'CLUSTER_FOR_EXECUTION_ID:'+@execution.id.to_s
    @cluster.execution_id = @execution.id
    @cluster.save
    @execution.cluster_id = @cluster.id
    puts 'cluster with name ' + @cluster.name + ' and id ' + @cluster.id.to_s + ' was created'


    ## debo prender las máquina que me toca
    @vm_number = @execution.vm_number
    @vm_type = @execution.vm_type
    puts 'I wil turn on ' + @vm_number.to_s + ' instances'
    puts ' of type' + @vm_type

    for i in 1..@vm_number
      @virtual_machine = launch_one_vm @vm_type, @cluster
      puts @virtual_machine.hostname + ' created'
    end

    @jobs_number = @execution.number_of_jobs
    # ahora debo crear los jobs
    puts 'I will create '
    puts @jobs_number.to_s + ' jobs'

    #debo identificar cuál es el directorio y su posición
    @input_dir = get_directory (@execution.inputs)

    # si no es nil es que hay directorio
    puts '@input_dir != nil'
    puts (@input_dir != nil).to_s

    if @input_dir != nil

         @directory = @input_dir.directory
         @cloud_files = @directory.cloud_files
          #tengo que sacar antes los inputs que son cloud_files ya son de tipo cloud_file
         inputs_cloud_files = get_cloud_files(@execution.inputs)

         puts '-----------------------'
         puts 'antes de todo'
         puts '-----------------------'

         inputs_cloud_files.each do |cf_in|
           puts '-----------------------'
           puts cf_in.name.to_s

         end

         puts '-----------------------'
         puts 'antes de todo'
         puts '-----------------------'


        for i in 1..@jobs_number
          puts 'creating job ' + i.to_s

          @current_file = @cloud_files[i-1]

          input_dir_to_file = @input_dir.dup
          input_dir_to_file.is_file = true
          input_dir_to_file.is_directory = false
          input_dir_to_file.cloud_file = @current_file
          #input_dir_to_file.execution_id = nil

          #para que no se vayan acumulando todos en cada iteración
          all_inputs = @execution.inputs
          all_inputs = all_inputs << input_dir_to_file

          #acá organizo todos los inputs que son archivos para que se metan al wget
          inputs_cloud_files = get_cloud_files(@execution.inputs)
          #inputs_cloud_files << @current_file

          @job = create_job @cluster, inputs_cloud_files , all_inputs, @execution.base_command, @execution

          #obtengo el tamaño del array para sacar el ultimo
          @execution.inputs.pop





        end


    end





  end

end

task :checkForJobs => :environment do

  puts 'I am going to check the queue for new messages'

  @sqs = Aws::Sqs.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)
  @queue = @sqs.queue(PRESCHEDULING_QUEUE, false)
  @msg = @queue.receive

  puts 'I just received the message:'
  puts @msg

  @parts = @msg.to_s.split(':')


  puts @parts[0]


  if(@parts[0]<=> SCHEDULE_JOB_MSG)

    @job=Job.find(@parts[1])
    @job.status = JOBS_STATUS[:PREPARING]
    @job.save

    puts 'I will prepare the job with id' + @job.id.to_s

    # acá obtengo la app que hay que ejecutar
    @app = @job.application.name
    # acá debo sacar el comando base y tener una mejor forma para describir eso

    @command = 'R --no-save INPUT1 $HOME \'PARAM1\' INPUT2 < INPUT_BASE1'
    # acá saco los inputs como un array
    @inputs = @job.inputs.to_s.split(';')

    # por cada input, le quito el nombre completo para cojer solo el
    #nombre del archivo, y luego se lo pongo al comando
    for i in  0..(@inputs.size-1) do

      @inputActual = @inputs[i]
      @inputPartes = @inputActual.to_s.split('/')

      @filename = @inputPartes.last
      @pattern = 'INPUT'+(i+1).to_s

      @command = @command.to_s.gsub(@pattern.to_s , @filename.to_s)

    end

    # lo mismo hago con los parametros, agrego cada uno al comando
    @params = @job.parameters.to_s.split(';')

    for i in  0..(@params.size-1) do
        @paramActual = @params[i]
        @pattern = 'PARAM'+(i+1).to_s

        @command = @command.to_s.gsub(@pattern.to_s , @paramActual.to_s)

    end

    #falta colocar bien lo del los inputs base
    @pattern = 'INPUT_BASE1'
    @replacement = 'Maxent2.R'

    @command = @command.to_s.gsub(@pattern.to_s , @replacement.to_s)

    puts 'This is the final command:'
    puts @command

    puts 'I will upload this command to S3'

    @commandFilename = 'command-'+ @job.id.to_s

    File.open(@commandFilename, 'w') do |stream|

           # acá le voy a poner un wget por cada input
            for i in  0..(@inputs.size-1) do

              @inputActual = @inputs[i]
              stream.puts 'wget ' + @inputActual.to_s
              puts 'adding input to wget:'+ @inputActual
            end

            # acá le pongo el input base que falta colocarlo bien
           stream.puts 'wget https://s3.amazonaws.com/eclouds/testFiles/Maxent2.R'
           stream.puts @command
    end

    f=File.open(@commandFilename, 'r')

    @s3 = Aws::S3.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)
    @bucket =  @s3.bucket('eclouds')


    # el permiso que toca ponerle es public-read
    @bucket.put('commands/' + f.path, f, {}, 'public-read')

    @location  = @bucket.public_link
    @commandFileUrl = @location + '/commands/'+@commandFilename.to_s

    puts 'successfully uploaded command file to ' + @commandFileUrl

    @job.script_url = @commandFileUrl

    @job.save

    puts 'Now I will choose a virtual machine to execute the job'

    @cluster = @job.cluster

    @vms = @cluster.virtual_machines.where("slots > ? AND state = ? ", 0, 'running')

    if @vms.size  > 0

      @chosen_vm = @vms.first

      puts 'I chose the virtual machine ' + @chosen_vm.hostname

      # acá borro el mensaje en la cola

      @msg.delete

      @job.virtual_machine = @chosen_vm
      @chosen_vm.slots = @chosen_vm.slots - 1

      @job.save
      # ahora debo poner el mensaje en la cola de scheduling
      @queue = @sqs.queue(SCHEDULING_QUEUE, create=false)
      @queue.send_message(@chosen_vm.hostname+';'+RUN_JOB_MSG + ';' + @job.id.to_s+';'+@job.application.installer_url+';'+@job.script_url+';'+@job.directory.name )
      @job.status = JOBS_STATUS[:QUEUED] + ':'+@chosen_vm.AMI_name
      @job.save
      @chosen_vm.save


     else
      puts 'No virtual machines available'
      @job.status = JOBS_STATUS[:WAITING]
      @job.save
    end




  end


end

task :checkJobStatus => :environment do

  puts 'I am going to check the queue for new messages'

  @sqs = Aws::Sqs.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)
  @queue = @sqs.queue(SCHEDULING_QUEUE)
  @msg = @queue.receive

  puts 'I just received the message:'
  puts @msg

  @parts = @msg.to_s.split(';')
  #  toca también por punto y coma porque las urls van separadas por :
  @parts2 = @msg.to_s.split(';')

  if(@parts[0] == INSTALLING_APP_MSG)

    # ahora encuentro el job que me dicen que esta en estado instalando
    @job = Job.find(@parts[1])
    @job.status = JOBS_STATUS[:INSTALLING] + ':' + @job.virtual_machine.AMI_name
    @job.save
    @msg.delete

  end

  if(@parts[0] == RUNNING_APP_MSG)

    # ahora encuentro el job que me dicen que esta en estado instalando
    @job = Job.find(@parts[1])
    @job.status = JOBS_STATUS[:RUNNING] + ':' + @job.virtual_machine.AMI_name
    @job.save
    @msg.delete
  end

  if(@parts[0] == UPLOADING_OUTPUTS_MSG)

    # ahora encuentro el job que me dicen que esta en estado instalando
    @job = Job.find(@parts[1])
    @job.status = JOBS_STATUS[:UPLOADING_OUTPUTS] + ':' + @job.virtual_machine.AMI_name
    @job.save
    @msg.delete
  end

  if(@parts2[0] == REGISTER_FILE_MSG)

    puts 'registering file'

    # ahora encuentro el job que me dicen que toca registrarle el output
    @job = Job.find(@parts2[1])
    # creo un nuevo cloud file para representar el archivo
    @cloud_file = CloudFile.new
    @file_url =@parts2[2]
    puts @file_url


    @file_url_parts = @file_url.split('/')
    @file_name = @file_url_parts.last

    @cloud_file.name = @file_name 
    @cloud_file.directory =  @job.directory
    @cloud_file.user = @job.user

    @url = @file_url_parts[4] + '/'+ @file_url_parts[5]+ '/' + @file_url_parts[6]
    @cloud_file.url = @url
    @cloud_file.avatar = @file_name

    @cloud_file.save

    @msg.delete
  end



end


####### funciones

# saca de los inputs pasados por parámtero cuál es el directorio
# si no hay ninguno retorna nil
def get_directory (inputs)

  inputs.each do |input|
    if input.is_directory?
        return input
    end
  end

  return nil
end

# saca de los inputs pasados por parámtero los que son archivos,
# ya son de tipo cloud_file
# si ninguno es archivo retorna nil
def get_cloud_files (inputs)

  @inputs_ret = Array.new
  inputs.each do |input|

    if input.is_file?
      @inputs_ret << input.cloud_file
    end
  end

  return  @inputs_ret
end

def create_cluster
  @cluster = current_user.clusters.new
end

# busca en la cadena string un patrón y lo reemplaza con replacement
def find_replace string, pattern, replacement
    string.gsub(pattern , replacement)
end

def create_job cluster, cloud_file_inputs, all_inputs, base_command, execution

  cloud_file_inputs.each do |cf_in|
    puts '-----------------------'
    puts cf_in.name.to_s

  end

  @job = Job.new

  @job.user_id = cluster.user.id
  @job.status = JOBS_STATUS[:PENDING]

  @job.start_time = DateTime.now

  @job.execution = execution

  @job.application = execution.application

  @job.save


  puts 'now I will generate the command'


  #acá armo el base command
  all_inputs.each do |input|


    if !input.is_directory?

      #primero debo sacar el valor del input
      ##@value = input.prefix + ' '
      @value = ''
      puts base_command

      if input.is_file?

        @value = @value + input.cloud_file.name

      else

        @value = @value + input.value
      end

      @pattern = 'INPUT'+(input.position-1).to_s
      @replacement = @value

      puts @pattern
      puts @replacement

      base_command = find_replace base_command, @pattern, @replacement

      puts base_command

    end



  end

    @command = base_command

    puts 'I will upload this command to S3: '
    puts @command

    @commandFilename = 'command-'+ @job.id.to_s

    File.open(@commandFilename, 'w') do |stream|

      # acá le voy a poner un wget por cada input
      for i in  0..(cloud_file_inputs.size-1) do

        @inputActual = cloud_file_inputs[i]
        stream.puts 'wget ' + @inputActual.complete_url
        puts 'adding input to wget:'+ @inputActual.complete_url
      end

      # acá le pongo el input base que falta colocarlo bien
      stream.puts 'wget https://s3.amazonaws.com/eclouds/testFiles/Maxent2.R'
      stream.puts @command
    end



    puts '-------------------------------'
    puts 'inputs succesfully added to command file'



    f=File.open(@commandFilename, 'r')

    @s3 = Aws::S3.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)
    @bucket =  @s3.bucket('eclouds')


    # el permiso que toca ponerle es public-read
    @bucket.put('commands/' + f.path, f, {}, 'public-read')

    @location  = @bucket.public_link
    @commandFileUrl = @location + '/commands/'+@commandFilename.to_s

    puts 'successfully uploaded command file to ' + @commandFileUrl



    @job.script_url = @commandFileUrl

    @job.save







  return @job



end

# lanza una máquina virtual con el tipo de instancia dado por parametro, y la asocia el cluster dado por parametro
def launch_one_vm(instance_type, cluster)

  @ec2 = Aws::Ec2.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)

  #@instances = @ec2.launch_instances( 'ami-d4ab2ebd' ,:group_ids => ['AppCientificas'],
   #                                   :instance_type => instance_type ,
    #                                  :user_data => 'EClouds Instance',
     #                                 :key_name => 'amazonKeys')
 # @instance = @instances[0]

  #@name = @instance[:aws_instance_id]
  @name = 'not real vm'

  @virtual_machine = VirtualMachine.new
  @virtual_machine.AMI_name = @name
  @virtual_machine.hostname = 'pending'
  puts 'obteniendo nombre de la vm'
  puts @virtual_machine.AMI_name
  @virtual_machine.slots = 1

  @virtual_machine.cluster_id = cluster.id

  puts @virtual_machine.cluster_id
  @virtual_machine.save

  @event = VirtualMachineEvent.new

  @event.action = VIRTUAL_MACHINE_EVENTS[:CREATED]
  @event.vm_id = @virtual_machine.id
  @event.user_id = cluster.user.id
  @event.save

  @virtual_machine


end