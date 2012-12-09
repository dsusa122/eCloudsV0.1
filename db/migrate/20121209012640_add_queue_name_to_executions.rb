class AddQueueNameToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :queue_name, :string
  end
end
