ActiveAdmin.register VirtualMachineEvent do

  index do
    column :id
    column :action
    column :created_at

    default_actions
  end
end
