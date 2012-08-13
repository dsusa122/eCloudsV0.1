class VirtualMachinesController < ApplicationController
  # GET /virtual_machines
  # GET /virtual_machines.json
  def index
    @virtual_machines = VirtualMachine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @virtual_machines }
    end
  end

  # GET /virtual_machines/1
  # GET /virtual_machines/1.json
  def show
    @virtual_machine = VirtualMachine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @virtual_machine }
    end
  end

  # GET /virtual_machines/new
  # GET /virtual_machines/new.json
  def new
    @virtual_machine = VirtualMachine.new
    @cluster =  Cluster.first

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @virtual_machine }
    end
  end

  # GET /virtdual_machines/1/edit
  def edit
    @virtual_machine = VirtualMachine.find(params[:id])
  end

  # POST /virtual_machines
  # POST /virtual_machines.json
  def create
    @virtual_machine = VirtualMachine.new(params[:virtual_machine])
    #@virtual_machine= @cluster.virtual_machines.build(params[:cluster])


    respond_to do |format|
      if @virtual_machine.save
        format.html { redirect_to @virtual_machine, notice: 'Virtual machine was successfully created.' }
        format.json { render json: @virtual_machine, status: :created, location: @virtual_machine }
      else
        format.html { render action: "new" }
        format.json { render json: @virtual_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /virtual_machines/1
  # PUT /virtual_machines/1.json
  def update
    @virtual_machine = VirtualMachine.find(params[:id])

    respond_to do |format|
      if @virtual_machine.update_attributes(params[:virtual_machine])
        format.html { redirect_to @virtual_machine, notice: 'Virtual machine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @virtual_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /virtual_machines/1
  # DELETE /virtual_machines/1.json
  def destroy
    @virtual_machine = VirtualMachine.find(params[:id])
    @virtual_machine.destroy

    respond_to do |format|
      format.html { redirect_to virtual_machines_url }
      format.json { head :no_content }
    end
  end
end
