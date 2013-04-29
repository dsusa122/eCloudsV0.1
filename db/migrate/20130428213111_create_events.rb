class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :execution_id
      t.string :description
      t.integer :code
      t.datetime :event_date

      t.timestamps
    end
  end
end
