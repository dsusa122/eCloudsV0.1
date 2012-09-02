class AddAvatarToCloudFile < ActiveRecord::Migration
  def change
    add_column :cloud_files, :avatar, :string
  end
end
