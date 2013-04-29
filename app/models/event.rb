class Event < ActiveRecord::Base
  attr_accessible :code, :description, :event_date, :execution_id
  belongs_to :execution


end
