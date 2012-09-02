class CloudFile < ActiveRecord::Base
  attr_accessible :name, :url, :avatar, :directory
  belongs_to :users

  mount_uploader :avatar, AvatarUploader

  def avatar=(obj)
    super(obj)
    # Put your callbacks here, e.g.
    ##self.moderated = false
  end



end
