class AddIndexUserIdToCloudFiles < ActiveRecord::Migration
  def change
    add_index :cloud_files, :user_id
  end
end
