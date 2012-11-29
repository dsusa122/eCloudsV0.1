class Input < ActiveRecord::Base
  attr_accessible :cloud_file_id, :description, :directory_id, :is_directory, :is_file, :name, :value_example, :application_id, :prefix, :position

  belongs_to :application
end
