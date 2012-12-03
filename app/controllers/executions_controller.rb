class ExecutionsController < InheritedResources::Base

  def create
    @execution = Execution.new(params[:execution])

    puts 'CREATE EXECUTION'
    puts params
    respond_to do |format|
      if @execution.save
        format.html { redirect_to define_execution_path(@execution), notice: 'Define the inputs for your execution' }
        format.json { render json: @execution, status: :created, location: @execution}
      else
        format.html { render action: "new" }
        format.json { render json: @execution.errors, status: :unprocessable_entity }
      end
    end
  end

  def define_execution

    @execution = Execution.find(params[:execution_id])

    @application = @execution.application

    @cloud_files = current_user.cloud_files.all
    @directories = current_user.directories.all
  end

  def new

    @execution = Execution.new

    @execution.user_id = current_user.id

    #@uploader.success_action_redirect = cloud_files_url

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cloud_file }
    end
  end

  def update


    @execution = Execution.find(params[:id])

    @application = @execution.application

    @base_command = @application.begin_command + ' '

    # estos son los inputs escogidos por el usuario
    @raw_inputs = params['inputs']


      if params[:calculate]

        @execution_params = params["execution_params"]

        @time_per_job = @execution_params["time_per_job"].to_i

        @execution.time_per_job=@time_per_job

        @execution.computing_hours = ((@time_per_job * @execution.number_of_jobs)/60).ceil

        respond_to do |format|
          if @execution.save
            format.html { redirect_to define_execution_part2_path(@execution), notice: 'Define the parameters for your execution' }
            format.json { render json: @execution, status: :created, location: @execution}
          else
            format.html { render action: "new" }
            format.json { render json: @execution.errors, status: :unprocessable_entity }
          end
        end

      else

        # este es el número de jobs total
        @num_jobs = 1


        i=0
        @application.inputs.order('position asc').each do |app_input|
          @raw_input = @raw_inputs[i.to_s]
          @execution_input = app_input.dup

          if app_input.is_file
            @file_id = @raw_input.to_i
            @cloud_file = current_user.cloud_files.find(@file_id)

            @execution_input.cloud_file = @cloud_file
            @execution_input.value = @cloud_file.name

            if @execution_input.prefix != nil or @execution_input.prefix != ''

              @base_command = @base_command +@execution_input.prefix + ' '+ @execution_input.value+ ' '

            else
              @base_command = @base_command + @execution_input.value+ ' '

            end

          elsif app_input.is_directory

            @directory_id = @raw_input.to_i
            @directory = current_user.directories.find(@directory_id)

            @execution_input.directory = @directory
            @execution_input.value = 'DIR('+@directory.name+')'
            @number_of_files = @directory.cloud_files.size
            @num_jobs = @num_jobs * @number_of_files

            if @execution_input.prefix != nil or @execution_input.prefix != ''

              @base_command = @base_command +@execution_input.prefix + ' '+ @execution_input.value+ ' '

            else
              @base_command = @base_command + @execution_input.value+ ' '

            end

          else
            @input_value = @raw_input
            @execution_input.value = @input_value

            if @execution_input.prefix != nil or @execution_input.prefix != ''

              @base_command = @base_command +@execution_input.prefix + ' '+ @execution_input.value+ ' '

            else
              @base_command = @base_command + @execution_input.value+ ' '

            end
          end
          i=i+1
        end

        puts 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

        puts @num_jobs

        @execution.base_command = @base_command
        @execution.number_of_jobs = @num_jobs

        respond_to do |format|
          if @execution.save
            format.html { redirect_to define_execution_part2_path(@execution), notice: 'Define the parameters for your execution' }
            format.json { render json: @execution, status: :created, location: @execution}
          else
            format.html { render action: "new" }
            format.json { render json: @execution.errors, status: :unprocessable_entity }
          end
        end

      end



  end

  def define_execution_part2

    @execution = Execution.find(params[:execution_id])

    @application = @execution.application

    @cloud_files = current_user.cloud_files.all
    @directories = current_user.directories.all


  end


end
