class Directory < ActiveRecord::Base
  acts_as_tree
  attr_accessible :name, :path, :parent_id
   belongs_to :user

  has_many :cloud_files, :dependent => :destroy
  has_many :jobs
  has_many :executions
  
end
