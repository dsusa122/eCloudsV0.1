class AddIndexTo < ActiveRecord::Migration
  def up
  end

  def change
    add_index :directories, :parent_id
    add_index :directories, :user_id
  end

  def down
  end
end
