task :checkForJobs => :environment do

  puts 'I am going to check the queue for new messages'

  @sqs = Aws::Sqs.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)
  @queue = @sqs.queue(PRESCHEDULING_QUEUE)
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

      @job.virtual_machine = @chosen_vm
      @chosen_vm.slots = @chosen_vm.slots - 1

      @job.save
      # ahora debo poner el mensaje en la cola de scheduling
      @queue = @sqs.queue(SCHEDULING_QUEUE)
      @queue.send_message(@chosen_vm.hostname+';'+RUN_JOB_MSG + ';' + @job.id.to_s+';'+@job.application.installer_url+';'+@job.script_url+';'+@job.outputdir )
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

  if(@parts[0] == INSTALLING_APP_MSG)

    # ahora encuentro el job que me dicen que esta en estado instalando
    @job = Job.find(@parts[1])
    @job.status = JOBS_STATUS[:INSTALLING] + ':' + @job.virtual_machine.hostname
    @job.save
    @msg.delete

  end

end