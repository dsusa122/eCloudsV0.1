class Execution < ActiveRecord::Base
  attr_accessible :application_id, :description, :directory_id, :end_date, :name, :start_date, :user_id, :base_command, :number_of_jobs, :computing_hours, :time_per_job

  belongs_to :user
  belongs_to :application
  has_many :jobs
  has_one :directory
  has_many :inputs
end
