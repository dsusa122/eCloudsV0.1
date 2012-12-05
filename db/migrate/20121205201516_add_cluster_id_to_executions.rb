class AddClusterIdToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :cluster_id, :integer
  end
end
