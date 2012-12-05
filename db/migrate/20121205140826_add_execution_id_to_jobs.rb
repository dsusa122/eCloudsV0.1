class AddExecutionIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :execution_id, :integer
  end
end
