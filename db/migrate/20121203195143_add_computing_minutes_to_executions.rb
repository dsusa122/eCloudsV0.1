class AddComputingMinutesToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :computing_minutes, :integer
  end
end
