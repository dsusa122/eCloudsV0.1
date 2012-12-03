class AddNumberOfJobsToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :number_of_jobs, :integer
  end
end
