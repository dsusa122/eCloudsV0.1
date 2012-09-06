class AddDirectoryIdtoCloudFile < ActiveRecord::Migration
  def up
    add_column :cloud_files, :directory_id, :integer
    add_index :cloud_files, :directory_id
  end

  def down
    remove_column :cloud_files, :directory_id
  end
end
