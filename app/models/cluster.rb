class Cluster < ActiveRecord::Base
  attr_accessible :name , :instance_type, :user_id, :execution_id


  has_many :virtual_machines ,:dependent => :destroy
  has_many :jobs

  belongs_to :user
  belongs_to :execution


end
