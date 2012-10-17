class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :application_id
      t.integer :user_id
      t.integer :cluster_id
      t.integer :virtual_machine_id
      t.string :parameters
      t.string :inputs
      t.string :outputdir
      t.string :status
      t.date :start_time
      t.date :end_time
      t.integer :wallclock_time

      t.timestamps
    end
  end
end
