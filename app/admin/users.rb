ActiveAdmin.register User do

  scope :pending_approval

  batch_action :approve do |selection|
    User.find(selection).each { |user| user.set_approved}
    redirect_to admin_users_path, :notice => "Users approved!"
  end

  batch_action :unapprove do |selection|
    User.find(selection).each { |user| user.set_unapproved}
    redirect_to admin_users_path, :notice => "Users Unapproved!"
  end

  index do
    column :id
    column :email
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    column :created_at
    selectable_column
  end

end
