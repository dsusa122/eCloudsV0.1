class RemodeSizeStringToCloudFile < ActiveRecord::Migration
  def up
  end

  def change
    remove_column :cloud_files, :size
  end

  def down
  end
end
