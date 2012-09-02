class AddUserIDtoDirectories < ActiveRecord::Migration
  def up
  end

  def change
    add_column :directories, :user_id, :integer
  end

  def down
  end
end
