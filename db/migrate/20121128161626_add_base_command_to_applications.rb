class AddBaseCommandToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :base_command, :string
  end
end
