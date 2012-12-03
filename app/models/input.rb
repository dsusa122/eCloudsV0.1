class Input < ActiveRecord::Base
  attr_accessible :cloud_file_id, :description, :directory_id, :is_directory, :is_file, :name, :value, :application_id, :prefix, :position

  belongs_to :application
  belongs_to :execution
  belongs_to :cloud_file
  belongs_to :directory
end
