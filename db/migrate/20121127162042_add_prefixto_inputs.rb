class AddPrefixtoInputs < ActiveRecord::Migration
  def up
  end

  def change
    add_column :inputs, :prefix, :string
  end

  def down
  end
end
