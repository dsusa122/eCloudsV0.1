class CreateVirtualMachines < ActiveRecord::Migration
  def change
    create_table :virtual_machines do |t|
      t.string :hostname
      t.integer :ram
      t.integer :cores
      t.integer :localStorage
      t.integer :clusterId

      t.timestamps
    end
  end
end
