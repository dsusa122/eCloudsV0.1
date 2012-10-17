class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :name
      t.string :version
      t.string :installer_url

      t.timestamps
    end
  end
end
