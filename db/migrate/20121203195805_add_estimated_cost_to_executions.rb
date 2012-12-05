class AddEstimatedCostToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :estimated_cost, :integer
  end
end
