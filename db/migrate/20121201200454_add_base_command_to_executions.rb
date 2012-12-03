class AddBaseCommandToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :base_command, :string
  end
end
