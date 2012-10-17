class AddSizeIntegerToCloudFile < ActiveRecord::Migration
  def change
    add_column :cloud_files, :size, :integer
  end
end
