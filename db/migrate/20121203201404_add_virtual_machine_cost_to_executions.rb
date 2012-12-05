class AddVirtualMachineCostToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :vm_cost, :decimal
  end
end
