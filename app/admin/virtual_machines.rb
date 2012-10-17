ActiveAdmin.register VirtualMachine do

  index do  |vm|
    column :id
    column :hostname
    column :cluster
    column 'user' do
        vm.id
    end
    column :ram
    column :cores
    column :localStorage
    column :created_at
    column :state
    default_actions
  end
  
end
