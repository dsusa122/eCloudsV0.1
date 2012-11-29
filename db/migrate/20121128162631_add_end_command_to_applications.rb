class AddEndCommandToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :end_command, :string
  end
end
