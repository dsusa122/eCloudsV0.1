class Remove < ActiveRecord::Migration
  def up
  end

  def change
    remove_column :virtual_machine_events, :event_date
  end

  def down
  end
end
