class AddTotalEstimatedCostToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :total_estimated_cost, :decimal
  end
end
