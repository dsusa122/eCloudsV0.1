ActiveAdmin.register CloudFile do

  #show do
   # attributes_table do
   #  row :user
    #end
  #end
  actions :index, :show

  index do
    column :id
    column :user do  |cloud_file|
      link_to "#{cloud_file.user.id} (#{cloud_file.user.email})"   , admin_user_path(cloud_file.user)
    end
    column :created_at

    column :directory

    column :size

    default_actions
  end

end
