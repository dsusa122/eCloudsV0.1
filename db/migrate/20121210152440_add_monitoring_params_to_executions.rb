class AddMonitoringParamsToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :running_jobs, :integer
    add_column :executions, :finished_jobs, :integer
    add_column :executions, :current_vms, :integer
    add_column :executions, :ended, :boolean
  end
end
