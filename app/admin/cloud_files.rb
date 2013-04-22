ActiveAdmin.register CloudFile do

  #show do
  # attributes_table do
  #  row :user
  #end
  #end
  actions :index, :show, :new, :delete

  index do
    column :id
    #column :user do  |cloud_file|
    #  link_to "#{cloud_file.user.id} (#{cloud_file.user.email})"   , admin_user_path(cloud_file.user)
    #end
    column :created_at

    column :directory

    column :size

    default_actions
  end

  #form :partial => "cloud_files/admin_form"
  form(:html => { :multipart => true }) do |f|
    f.inputs "Create File" do
      f.input :avatar, :as => :file
      f.input :directory_id,:as=>:select, :collection=>Directory.find_all_by_is_public(true)
    end

    f.buttons

  end
  controller do
    before_filter :authenticate_admin_user!
    def create

      @cloud_file = CloudFile.new(params[:cloud_file])

      @cloud_file.url =@cloud_file.avatar.store_dir.to_s

      @cloud_file.name = @cloud_file.avatar.filename.to_s

      @cloud_file.size = @cloud_file.avatar.file.size


      if @cloud_file.save

        @cloud_file.url = @cloud_file.url + @cloud_file.id.to_s + "/" + @cloud_file.name
        @cloud_file.save

        flash[:notice] = "Successfully uploaded the file."


        redirect_to admin_cloud_files_path
      else
        render :action => 'new'
      end

      puts @cloud_file



    end
  end

end
