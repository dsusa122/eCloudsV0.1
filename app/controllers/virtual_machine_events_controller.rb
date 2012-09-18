class VirtualMachineEventsController < ApplicationController
  # GET /virtual_machine_events
  # GET /virtual_machine_events.json
  def index
    @virtual_machine_events = VirtualMachineEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @virtual_machine_events }
    end
  end

  # GET /virtual_machine_events/1
  # GET /virtual_machine_events/1.json
  def show
    @virtual_machine_event = VirtualMachineEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @virtual_machine_event }
    end
  end

  # GET /virtual_machine_events/new
  # GET /virtual_machine_events/new.json
  def new
    @virtual_machine_event = VirtualMachineEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @virtual_machine_event }
    end
  end

  # GET /virtual_machine_events/1/edit
  def edit
    @virtual_machine_event = VirtualMachineEvent.find(params[:id])
  end

  # POST /virtual_machine_events
  # POST /virtual_machine_events.json
  def create
    @virtual_machine_event = VirtualMachineEvent.new(params[:virtual_machine_event])

    respond_to do |format|
      if @virtual_machine_event.save
        format.html { redirect_to @virtual_machine_event, notice: 'Virtual machine event was successfully created.' }
        format.json { render json: @virtual_machine_event, status: :created, location: @virtual_machine_event }
      else
        format.html { render action: "new" }
        format.json { render json: @virtual_machine_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /virtual_machine_events/1
  # PUT /virtual_machine_events/1.json
  def update
    @virtual_machine_event = VirtualMachineEvent.find(params[:id])

    respond_to do |format|
      if @virtual_machine_event.update_attributes(params[:virtual_machine_event])
        format.html { redirect_to @virtual_machine_event, notice: 'Virtual machine event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @virtual_machine_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /virtual_machine_events/1
  # DELETE /virtual_machine_events/1.json
  def destroy
    @virtual_machine_event = VirtualMachineEvent.find(params[:id])
    @virtual_machine_event.destroy

    respond_to do |format|
      format.html { redirect_to virtual_machine_events_url }
      format.json { head :no_content }
    end
  end
end
