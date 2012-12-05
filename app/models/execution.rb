class Execution < ActiveRecord::Base
  attr_accessible :application_id, :description, :directory_id, :end_date, :name, :start_date, :user_id, :base_command, :number_of_jobs, :computing_hours, :time_per_job, :computing_minutes, :vm_cost, :vm_number, :total_estimated_cost, :vm_type, :estimated_time_minutes, :cluster_id, :example_command

  belongs_to :user
  belongs_to :application
  has_many :jobs
  belongs_to :directory
  has_many :inputs
  has_one :cluster
end
