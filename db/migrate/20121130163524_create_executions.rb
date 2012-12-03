class CreateExecutions < ActiveRecord::Migration
  def change
    create_table :executions do |t|
      t.integer :user_id
      t.integer :application_id
      t.integer :directory_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
