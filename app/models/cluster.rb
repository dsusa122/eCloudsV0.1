class Cluster < ActiveRecord::Base
  attr_accessible :name , :instance_type, :user_id


  has_many :virtual_machines

  belongs_to :users
end
