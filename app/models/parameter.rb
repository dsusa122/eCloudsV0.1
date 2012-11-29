class Parameter < ActiveRecord::Base
  attr_accessible :application_id, :name, :prefix, :value_example

  belongs_to :application

end
