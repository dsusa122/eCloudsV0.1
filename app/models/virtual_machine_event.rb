class VirtualMachineEvent < ActiveRecord::Base
  attr_accessible :action, :user_id, :vm_id

  belongs_to :user


end
