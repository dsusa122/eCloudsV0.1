class AddClusterIdToVirtualMachines < ActiveRecord::Migration
  def change
    add_column :virtual_machines, :cluster_id, :integer
  end
end
