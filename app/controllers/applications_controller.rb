class ApplicationsController < InheritedResources::Base

  def new
    @application = Application.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @application }
    end
  end

  # POST /operating_systems
  # POST /operating_systems.json
  def create
    @application = Application.new(params[:application])

    session[:current_application_id]=@application

    respond_to do |format|
      if @application.save
        format.html { redirect_to add_inputs_path(@application), notice: 'Application was successfully created.' }
        format.json { render json: @application, status: :created, location: @application}
      else
        format.html { render action: "new" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_inputs
    @application = Application.find(params[:application_id])
    @input = @application.inputs.new

  end

  def add_parameters
    @application = Application.find(params[:application_id])
    @parameter = @application.parameters.new

  end


  def add_one_input
    @application = Application.find(params[:application_id])
    @input =  Input.find(params[:input_id])
    @input.name =  params[:name]
    puts params
    @input.application_id = @application.id

    respond_to do |format|
      if @input.save
        format.html { redirect_to add_inputs_path(@application), notice: 'Input successfully added.' }
        format.json { render json: @application, status: :created, location: @application}
      else
        format.html { render action: "new" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end

    redirect_to add_inputs_path(@application)

  end

  def organize_parameters
    @application = Application.find(params[:application_id])


      # si no están ordenados los organiza

      if @application.inputs.first == nil
        i=0
        @application.inputs.each do |input|
          i=i+1
          input.position = i
          input.save
        end
      end

      @precommand_example =''
      @precommand_base =''

      @ordered_inputs = @application.inputs.order('position asc')

       i=0
      @ordered_inputs.each do |input|
        i=i+1
        @value_example
        @value_base
        if input.value == nil || input.value == ''
          @value_example = input.prefix + ' INPUT'+i.to_s
        else
          @value_example = input.prefix + ' ' +input.value
        end

        @value_base = input.prefix + ' INPUT'+i.to_s

        @precommand_example = @precommand_example + ' ' + @value_example
        @precommand_base =  @precommand_base + ' ' + @value_base
      end

      if @application.begin_command == nil
        @application.begin_command=''
      end

      if @application.end_command == nil
        @application.end_command=''
      end

      @application.base_command = @application.begin_command + @precommand_base + @application.end_command
      @example_command =  @application.begin_command + @precommand_example + @application.end_command


  end

  def update
    @application = Application.find(params[:id])

    puts 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    puts @application.begin_command
    puts params
    puts params[:id]

    respond_to do |format|
      if @application.save
        format.html { redirect_to organize_parameters_path(@application), notice: 'Application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

end
