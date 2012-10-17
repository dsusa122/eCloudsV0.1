class Job < ActiveRecord::Base

   attr_accessible :application_id, :cluster_id, :end_time, :inputs, :outputdir, :parameters, :start_time, :status, :user_id, :virtual_machine_id, :wallclock_time

  belongs_to :user
  belongs_to :cluster
  belongs_to :application
  belongs_to :virtual_machine
end
