class JobsController < InheritedResources::Base

  before_filter :authenticate_user!

  def index
    @jobs = current_user.jobs.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  # GET /cloud_files/new
  # GET /cloud_files/new.json
  def new

    @job = Job.new
    @applications = Application.all
    @clusters = current_user.clusters.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # POST /cloud_files
  # POST /cloud_files.json
  def create


    @job = Job.new(params[:job])

    @job.user_id = current_user.id
    @job.status = JOBS_STATUS[:PENDING]
    
    @job.start_time = DateTime.now


    respond_to do |format|
      if @job.save

        # ahora voy a poner el job en la cola de prescheduling
        @sqs = Aws::Sqs.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)
        @queue = @sqs.queue(PRESCHEDULING_QUEUE)
        @msg = SCHEDULE_JOB_MSG + ':' + @job.id.to_s
        @queue.send_message(@msg)

        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end


  end

end
