class InputsController < InheritedResources::Base
  def create

    if  params[:next]


      @input = Input.new(params[:input]   )

      @application = Application.find(@input.application_id)

      respond_to do |format|
        if @application.save
          format.html { redirect_to organize_parameters_path(@application), notice: 'Input successfully added' }
          format.json { render json: @application, status: :created, location: @application}
        else
          format.html { render action: "new" }
          format.json { render json: @application.errors, status: :unprocessable_entity }
        end
      end


    else

      @input = Input.new(params[:input]   )

      @application = Application.find(@input.application_id)




      respond_to do |format|
        if @input.save
          format.html { redirect_to add_inputs_path(@application), notice: 'Input successfully added' }
          format.json { render json: @application, status: :created, location: @application}
        else
          format.html { render action: "new" }
          format.json { render json: @application.errors, status: :unprocessable_entity }
        end
      end


    end


  end


  def destroy
    @input = Input.find(params[:id])
    @input.destroy

    @application = session[:current_application_id]

    respond_to do |format|
      format.html { redirect_to add_inputs_path(@application) }
      format.json { head :no_content }
    end
  end

  def new

    @application = Application.find(params[:application_id])
    @input = @application.inputs.new


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @application }
    end
  end



end
