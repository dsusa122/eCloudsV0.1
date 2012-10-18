class AddSlotsToVirtualMachine < ActiveRecord::Migration
  def change
    add_column :virtual_machines, :slots, :integer
  end
end
