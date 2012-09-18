class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable ,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me , :current_directory
  # attr_accessible :title, :body
  #attr_protected :current_directory



  has_many :clusters

  has_many :cloud_files

  has_many :directories

  has_many :virtual_machine_events


end
