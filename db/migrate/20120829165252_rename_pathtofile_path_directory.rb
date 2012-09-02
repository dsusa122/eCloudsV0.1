class RenamePathtofilePathDirectory < ActiveRecord::Migration
  def up
  end
  def change
    rename_column :directories, :path, :directory_path
  end

  def down
  end
end
