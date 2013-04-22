class DirectoriesController < ApplicationController

  before_filter :authenticate_user!, :authenticate_admin_user!

  # GET /directories
  # GET /directories.json
  def index
    @directories = current_user.directories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @directories }
    end
  end

  # GET /directories/1
  # GET /directories/1.json
  def show
    @directory = current_user.directories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @directory }
    end
  end

  # GET /directories/new
  # GET /directories/new.json
  def new


    @directory = current_user.directories.new
    #if there is "folder_id" param, we know that we are under a folder, thus, we will essentially create a subfolder
    if params[:directory_id] #if we want to create a folder inside another folder

      #we still need to set the @current_folder to make the buttons working fine
      @current_directory = current_user.directories.find(params[:directory_id])

      #then we make sure the folder we are creating has a parent folder which is the @current_folder
      @directory.parent_id = @current_directory.id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @directory }
    end
  end

  # GET /directories/1/edit
  def edit
    @directory = current_user.directories.find(params[:directory_id])

    @current_directory = @directory.parent    #this is just for breadcrumbs

  end

  # POST /directories
  # POST /directories.json
  def create


    @directory = current_user.directories.new(params[:directory])
    if @directory.save

      flash[:notice] = "Successfully created folder."

      if @directory.parent #checking if we have a parent folder on this one
        redirect_to browse_path(@directory.parent)  #then we redirect to the parent folder
      else
        redirect_to data_home_path #if not, redirect back to home page
      end
    else
      render :action => 'new'
    end


  end

  # PUT /directories/1
  # PUT /directories/1.json
  def update
    @directory = current_user.directories.find(params[:id])

    respond_to do |format|
      if @directory.update_attributes(params[:directory])
        format.html { redirect_to @directory, notice: 'Directory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @directory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directories/1
  # DELETE /directories/1.json
  def destroy
    @directory = current_user.directories.find(params[:id])

    @parent_directory = @directory.parent #grabbing the parent folder

    #this will destroy the folder along with all the contents inside
    #sub folders will also be deleted too as well as all files inside
    @directory.destroy
    flash[:notice] = "Successfully deleted the folder and all the contents inside."

    #redirect to a relevant path depending on the parent folder
    if @parent_directory
      redirect_to browse_path(@parent_directory)
    else
      redirect_to data_home_path
    end
  end
end
