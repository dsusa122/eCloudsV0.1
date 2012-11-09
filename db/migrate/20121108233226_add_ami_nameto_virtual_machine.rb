class AddAmiNametoVirtualMachine < ActiveRecord::Migration
  def up
  end

  def change
    add_column :virtual_machines, :AMI_name, :string
  end

  def down
  end
end
