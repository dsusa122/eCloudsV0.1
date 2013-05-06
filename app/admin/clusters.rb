ActiveAdmin.register Cluster do
  actions :index, :show

  index do
    column :id
    column :name
    column :user
    column :created_at
    column :instance_type
    default_actions

  end

  show do |cluster|

    attributes_table do
      row :name
      row :id
      row :created_at
      row :instance_type

      row 'Virtual Machines'   do
        #cluster.virtual_machines.each do    |vm|
          #vm.hostname
          #end
      end

    end
  end



  
end
