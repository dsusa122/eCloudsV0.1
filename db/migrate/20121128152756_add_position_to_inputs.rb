class AddPositionToInputs < ActiveRecord::Migration
  def change
    add_column :inputs, :position, :integer
  end
end
