class AddBeginCommandToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :begin_command, :string
  end
end
