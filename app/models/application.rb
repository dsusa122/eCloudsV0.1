class Application < ActiveRecord::Base
  attr_accessible :installer_url, :name, :version ,:begin_command, :base_command, :end_command

  has_many :clusters
  has_many :parameters ,:dependent => :destroy
  has_many :inputs , :dependent => :destroy
end
