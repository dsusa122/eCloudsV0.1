ActiveAdmin.register Directory do
   index do
     column :id
     column :name
     column :created_at
     column :user
     default_actions
   end
end
