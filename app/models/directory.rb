class Directory < ActiveRecord::Base
  attr_accessible :name, :path

  belongs_to :users
end
