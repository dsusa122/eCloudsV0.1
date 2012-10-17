class AddSizeToCloudFile < ActiveRecord::Migration
  def change
    add_column :cloud_files, :size, :string
  end
end
