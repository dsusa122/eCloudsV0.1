class AddExecutionIdToInputs < ActiveRecord::Migration
  def change
    add_column :inputs, :execution_id, :integer
  end
end
