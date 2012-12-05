class AddVmNumberToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :vm_number, :integer
  end
end
