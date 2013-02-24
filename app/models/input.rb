class Input < ActiveRecord::Base
  attr_accessible :cloud_file_id, :description, :directory_id, :is_directory, :is_file, :name, :value, :application_id, :prefix, :position, :execution_id

  validates :description, :length => { :maximum => 200}
  validates :name, :presence => true,:length => { :maximum => 50}


  belongs_to :application
  belongs_to :execution
  belongs_to :cloud_file
  belongs_to :directory
end
