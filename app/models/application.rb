class Application < ActiveRecord::Base
  attr_accessible :installer_url, :name, :version ,:begin_command, :base_command, :end_command, :image
  validates :installer_url, :presence => true


  mount_uploader :image, ImageUploader

  has_many :clusters
  has_many :parameters ,:dependent => :destroy
  has_many :inputs , :dependent => :destroy
end