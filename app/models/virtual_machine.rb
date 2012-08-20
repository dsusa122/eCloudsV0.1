class VirtualMachine < ActiveRecord::Base
  attr_accessible :cores, :hostname, :localStorage, :ram , :cluster_id
  belongs_to :cluster
end
