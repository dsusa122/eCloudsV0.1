class Application < ActiveRecord::Base
  attr_accessible :installer_url, :name, :version

  has_many :clusters
end
