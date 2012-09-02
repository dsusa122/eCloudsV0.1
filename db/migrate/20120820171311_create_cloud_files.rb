class CreateCloudFiles < ActiveRecord::Migration
  def change
    create_table :cloud_files do |t|
      t.string :name
      t.integer :type
      t.string :url
      t.integer :user_id
      t.timestamps
    end
  end
end
