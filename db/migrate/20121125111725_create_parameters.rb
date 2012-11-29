class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.string :name
      t.string :prefix
      t.string :value
      t.integer :application_id

      t.timestamps
    end
  end
end
