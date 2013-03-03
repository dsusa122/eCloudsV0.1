class CloudFile < ActiveRecord::Base

  PRODUCTION_BUCKET  = ENV["S3_BUCKET_PROD"]
  DEVELOPMENT_BUCKET = ENV["S3_BUCKET_DEV"]
  STAGING_BUCKET = ENV["S3_BUCKET_STAGING"]

  AMAZON_S3_BASE_URL =   "https://s3.amazonaws.com/"


  PRODUCTION_BUCKET_URL =AMAZON_S3_BASE_URL + PRODUCTION_BUCKET
  DEVELOPMENT_BUCKET_URL =AMAZON_S3_BASE_URL + DEVELOPMENT_BUCKET
  STAGING_BUCKET_URL = AMAZON_S3_BASE_URL + STAGING_BUCKET

  attr_accessible :name, :url, :avatar, :directory_id, :updated_at
  belongs_to :user
  belongs_to :directory

  validates :name, :presence => true, :length => { :maximum => 50}

  mount_uploader :avatar, AvatarUploader

  def avatar=(obj)
    super(obj)
    # Put your callbacks here, e.g.
    ##self.moderated = false
  end

  def complete_url
    if Rails.env.development?
      return DEVELOPMENT_BUCKET_URL + self.url
    elsif Rails.env.production?
      return PRODUCTION_BUCKET_URL + self.url
    end
  end



end
