class AddExampleCommandToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :example_command, :string
  end
end
