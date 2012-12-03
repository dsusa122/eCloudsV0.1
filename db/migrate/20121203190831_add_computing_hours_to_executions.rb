class AddComputingHoursToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :computing_hours, :integer
  end
end
