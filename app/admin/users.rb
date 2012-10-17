ActiveAdmin.register User do

  index do
    column :id
    column :email
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    column :created_at
  end

end
