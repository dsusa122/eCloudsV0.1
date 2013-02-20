class AddIsBusytoVirtualMachines2 < ActiveRecord::Migration
  def up
  end

  def change
    add_column :virtual_machines, :is_busy, :boolean

  end
  def down
  end
end
