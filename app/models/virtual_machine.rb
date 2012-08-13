class VirtualMachine < ActiveRecord::Base
  attr_accessible :cores, :hostname, :localStorage, :ram
  belongs_to :cluster
end
