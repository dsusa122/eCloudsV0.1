class FixColumnNameCloudfileType < ActiveRecord::Migration
  def up
  end

  def change
    rename_column :cloud_files, :type, :directory
  end

  def down
  end
end
