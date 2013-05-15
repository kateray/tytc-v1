class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:github]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password, :password_confirmation, :remember_me, :provider, :uid
  
  has_many :links
  has_many :votes
  has_many :comments
  has_many :tags
  has_many :languages
  has_many :categories
  
  validates :username,
    :presence => true,
    :uniqueness => true,
    :length => {:minimum => 1, :maximum => 254}

  def email_required?
    false
  end
  
  def add_github_login(auth)
    self.github_id = auth['uid']
    self.github_username = auth['info']['nickname']
    self.github_email = auth['info']['email']
  end
  
  def self.github_find_or_create(auth)
    unless user = User.find_by_github_id(auth['uid'])
      create! do |user|
        user.github_id = auth['uid']
        user.github_username = auth['info']['nickname']
        user.username = auth['info']['nickname']
        user.github_email = auth['info']['email']
      end
    end
    return user
  end
  
  def require_password?
    self.crypted_password && self.crypted_password_changed?
  end
  
end