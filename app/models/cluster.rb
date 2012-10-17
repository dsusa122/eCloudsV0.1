class Cluster < ActiveRecord::Base
  attr_accessible :name , :instance_type, :user_id


  has_many :virtual_machines
  has_many :jobs

  belongs_to :user


end
