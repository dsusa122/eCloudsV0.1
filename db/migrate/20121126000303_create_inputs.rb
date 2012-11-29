class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.string :name
      t.boolean :is_file
      t.boolean :is_directory
      t.string :value
      t.integer :cloud_file_id
      t.integer :directory_id
      t.string :description

      t.timestamps
    end
  end
end
