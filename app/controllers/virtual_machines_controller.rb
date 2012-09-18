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

  def stop
    @virtual_machine = VirtualMachine.find( params[:virtual_machine_id])
    @current_cluster = Cluster.find ( params[:current_cluster_id])

    stop_one_vm(@virtual_machine)


    flash[:notice]   = @virtual_machine.hostname
    redirect_to @current_cluster
  end

  def stop_all

    @current_cluster = Cluster.find ( params[:current_cluster_id])

    @current_cluster.virtual_machines.each do |virtual_machine|

      if !(virtual_machine.state == "terminated" )

        stop_one_vm(virtual_machine)

      end

    end

    redirect_to @current_cluster
  end

  def stop_one_vm(vm)

    if !(vm.state == "stopped" or vm.state == "stopping")


        @ec2 = Aws::Ec2.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)

        @ec2.stop_instances([vm.hostname])

        # acá genero el evento y lo guardo
        @event = VirtualMachineEvent.new

        @event.action = VIRTUAL_MACHINE_EVENTS[:STOPPED]
        @event.vm_id = vm.id
        @event.user_id = current_user.id
        @event.save


    end

  end


  def start
    @virtual_machine = VirtualMachine.find( params[:virtual_machine_id])
    @current_cluster = Cluster.find ( params[:current_cluster_id])

    start_one_vm(@virtual_machine)

    flash[:notice]   = @virtual_machine.hostname
    redirect_to @current_cluster
  end

  def start_all

    @current_cluster = Cluster.find ( params[:current_cluster_id])

    @current_cluster.virtual_machines.each do |virtual_machine|

      if !(virtual_machine.state == "terminated" )

          start_one_vm(virtual_machine)

      end

    end

    redirect_to @current_cluster

  end

  def start_one_vm(vm)

    if !(vm.state == "running" or vm.state == "pending")

      @ec2 = Aws::Ec2.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)

      @ec2.start_instances([vm.hostname])

      # acá genero el evento y lo guardo
      @event = VirtualMachineEvent.new

      @event.action = VIRTUAL_MACHINE_EVENTS[:STARTED]
      @event.vm_id = vm.id
      @event.user_id = current_user.id
      @event.save

    end
  end


  def reboot
    @virtual_machine = VirtualMachine.find( params[:virtual_machine_id])
    @current_cluster = Cluster.find ( params[:current_cluster_id])

    reboot_one_vm(@virtual_machine)


    flash[:notice]   = @virtual_machine.hostname
    redirect_to @current_cluster
  end

  def reboot_all

    @current_cluster = Cluster.find ( params[:current_cluster_id])

    @current_cluster.virtual_machines.each do |virtual_machine|

      if !(virtual_machine.state == "terminated" )

        reboot_one_vm(virtual_machine)

      end

    end

    redirect_to @current_cluster

  end


  def reboot_one_vm(vm)

    if !(vm.state == "stopped" or vm.state == "stopping")

      @ec2 = Aws::Ec2.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)

      @ec2.reboot_instances([vm.hostname])

      # acá genero el evento y lo guardo
      @event = VirtualMachineEvent.new

      @event.action = VIRTUAL_MACHINE_EVENTS[:REBOOTED]
      @event.vm_id = vm.id
      @event.user_id = current_user.id
      @event.save

    end
  end

  def terminate
    @virtual_machine = VirtualMachine.find( params[:virtual_machine_id])
    @current_cluster = Cluster.find ( params[:current_cluster_id])

   terminate_one_vm(@virtual_machine)


    flash[:notice]   = @virtual_machine.hostname
    redirect_to @current_cluster
  end

  def terminate_all

    @current_cluster = Cluster.find ( params[:current_cluster_id])

    @current_cluster.virtual_machines.each do |virtual_machine|

      if !(virtual_machine.state == "terminated" )

        terminate_one_vm(virtual_machine)

      end

    end

    redirect_to @current_cluster

  end


  def terminate_one_vm(vm)

    @ec2 = Aws::Ec2.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)

    @ec2.terminate_instances([vm.hostname])

    # acá genero el evento y lo guardo
    @event = VirtualMachineEvent.new

    @event.action = VIRTUAL_MACHINE_EVENTS[:TERMINATED]
    @event.vm_id = vm.id
    @event.user_id = current_user.id
    @event.save

  end
end
