class AddTimePerJobToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :time_per_job, :integer
  end
end
