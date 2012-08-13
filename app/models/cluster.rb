class Cluster < ActiveRecord::Base
  attr_accessible :name , :instance_type_id

  has_many :virtual_machines
end
