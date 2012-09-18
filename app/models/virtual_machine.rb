class VirtualMachine < ActiveRecord::Base
  attr_accessible :cores, :hostname, :localStorage, :ram , :cluster_id
  belongs_to :cluster

  #acutaliza y salva el estado de la maq virtual
  def current_state

    if self.state == "terminated"
      return self.state
    else
      @ec2 = Aws::Ec2.new(AMAZON_ACCESS_KEY_ID, AMAZON_SECRET_ACCESS_KEY)

      @vm_description = @ec2.describe_instances([self.hostname])

      @state = @vm_description[0][:aws_state]

      self.state = @state
      self.save

      return @state

    end





  end
end
