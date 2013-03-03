class Application < ActiveRecord::Base
  attr_accessible :installer_url, :name, :version, :image ,:begin_command, :base_command, :end_command, :description
  validates :installer_url, :presence => true
  validates :version, :presence => true
  validates :description, :presence => true, :length => {:maximum => 140}

  has_many :clusters
  has_many :parameters ,:dependent => :destroy
  has_many :inputs , :dependent => :destroy

  mount_uploader :image, ImageUploader
end