task :checkQueue => :environment do
  puts 'I wil check the queue to see if I have to execute any job'

  @sqs = Aws::Sqs.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)
  @queue = @sqs.queue(SCHEDULING_QUEUE)

  @msg = @queue.receive

  puts 'I just received the message:'
  puts @msg



  if @msg.to_s.split(';')[1] == RUN_JOB_MSG  and  @msg.to_s.split(';').first  != ''

    @msg_parts = @msg.to_s.split(';')

    @host = Socket.gethostname
    @host = @host.split('.').first
    puts 'my hostname is: '
    puts @host.to_s

    @targetHostname = @msg_parts[0].split('.').first
    puts 'the target hostname is: '
    puts @targetHostname

      if @targetHostname != @host
        puts 'this is not for me '
      else

        #borro el mensaje
        @msg.delete



        @app_installer_url = @msg_parts[3].to_s
        @installation_file_name = @app_installer_url.split('/').last

        @installing_msg = INSTALLING_APP_MSG+';'+ @msg_parts[2].to_s
        @queue.send_message(@installing_msg)

        if( File.exists? @installation_file_name )
          puts 'application already installed'
        else

          puts 'I will download the installer file'
          puts '########################################'
          puts 'wget ' + @app_installer_url

          system('wget ' + @app_installer_url )


          puts '########################################'
          puts 'chmod 755 '+ @installation_file_name

          system( 'chmod 755 '+ @installation_file_name )

          puts 'Now I will execute the installer file'
          system( 'chown root '+ @installation_file_name)
          system( 'sudo ./'+@installation_file_name)

          system( 'touch '+@installation_file_name)

        end


        puts 'Creating output dir'
        system( 'mkdir jobOutputs')
        system( 'cd jobOutputs')



        puts 'I will download the command file'
        @command_url = @msg_parts[4].to_s

        puts '########################################'
        puts 'wget ' + @command_url

        system('wget ' + @command_url )

        @running_msg = RUNNING_APP_MSG+';'+ @msg_parts[2].to_s
        @queue.send_message(@running_msg)

        @command_file_name = @command_url.split('/').last

        puts '########################################'
        puts 'chmod 755 ' + @command_file_name
        system( 'chmod 755 ' + @command_file_name )

        @running = INSTALLING_APP_MSG+';'+ @msg_parts[2].to_s
        @queue.send_message(@installing_msg)

        puts './'+@command_file_name + ' > jobsOutputs/output.txt'
        system( './'+@command_file_name + ' > jobsOutputs/output.txt' )

        puts 'I will upload the outputs'

        @uploading_outs_msg = UPLOADING_OUTPUTS_MSG+';'+ @msg_parts[2].to_s
        @queue.send_message(@uploading_outs_msg)

        @outputFiles = Dir['jobsOutputs/*']

        @job_id = @msg_parts[2].to_s

        @s3 = Aws::S3.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)
        @bucket =  @s3.bucket('eclouds')

        for i in  0..(@outputFiles.size-1) do

          @file = @outputFiles[i]

          @filename = @file.split('/').last

          puts 'uploading '+@filename.to_s
          f=File.open(@file, 'r')

          # el permiso que toca ponerle es public-read
          @bucket.put('outputs/'+@job_id +'/'+ @filename, f, {}, 'public-read')

          @location  = @bucket.public_link
          @fileUrl = @location + '/outputs/'+@job_id+'/'+@filename.to_s

          puts 'successfully uploaded command file to ' + @fileUrl

          @registerFile = REGISTER_FILE_MSG+';'+ @msg_parts[2].to_s+';'+@fileUrl
          @queue.send_message(@registerFile)

          File.delete(@file)

        end


    end

    
    @finished_job_msg = FINISHED_JOB_MSG+';'+ @msg_parts[2].to_s
    @queue.send_message(@finished_job_msg)

  end



end
