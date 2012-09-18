class CreateVirtualMachineEvents < ActiveRecord::Migration
  def change
    create_table :virtual_machine_events do |t|
      t.date :event_date
      t.string :action
      t.integer :vm_id
      t.integer :user_id

      t.timestamps
    end
  end
end
