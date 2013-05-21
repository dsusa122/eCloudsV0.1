class AddTotalCostToExecutionAndFundsToUser < ActiveRecord::Migration
  def change
    add_column :executions, :total_cost, :decimal
    add_column :users, :funds, :decimal
  end
end
