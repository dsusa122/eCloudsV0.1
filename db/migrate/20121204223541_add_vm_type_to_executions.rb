class AddVmTypeToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :vm_type, :string
  end
end
