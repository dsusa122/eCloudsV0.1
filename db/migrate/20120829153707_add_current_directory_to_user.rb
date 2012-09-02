class AddCurrentDirectoryToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_directory_id, :integer
  end
end
