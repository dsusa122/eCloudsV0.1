class Cluster < ActiveRecord::Base
  attr_accessible :name , :instance_type_id , :user_id

  has_many :virtual_machines

  belongs_to :users
end
