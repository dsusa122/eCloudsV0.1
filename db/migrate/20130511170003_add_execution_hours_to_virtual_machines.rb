class AddExecutionHoursToVirtualMachines < ActiveRecord::Migration
  def change
    add_column :virtual_machines, :execution_hours, :integer
  end
end
