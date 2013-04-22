ActiveAdmin.register Directory do
   index do
     column :id
     column :name
     column :created_at
     column :user
     default_actions
   end

   form do |f|
     f.inputs "Directory Details" do
       f.input :name
       f.input :is_public
     end
     f.actions
   end

end
