class BrowserController < ApplicationController

  #this action is for viewing folders
  def browse
    #get the folders owned/created by the current_user
    @current_directory = current_user.directories.find(params[:directory_id])

    if @current_directory

      #getting the folders which are inside this @current_folder
      @directories = @current_directory.children

      #We need to fix this to show files under a specific folder if we are viewing that folder
      @cloud_files =  @current_directory.cloud_files

      render :action => "index"
    else
      flash[:error] = "Don't be cheeky! Mind your own folders!"
      redirect_to root_url
    end
  end

  def index
    if user_signed_in?
      #show only root folders (which have no parent folders)
      @directories = current_user.directories.roots

      #show only root files which has no "folder_id"
      @cloud_files = current_user.cloud_files.where("directory_id is NULL")
    end
  end

end
