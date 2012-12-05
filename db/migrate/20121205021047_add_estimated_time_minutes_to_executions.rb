class AddEstimatedTimeMinutesToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :estimated_time_minutes, :decimal
  end
end
