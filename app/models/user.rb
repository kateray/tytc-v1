class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password, :password_confirmation, :remember_me, :provider, :uid, :login
  attr_accessor :login

  has_many :links
  has_many :votes
  has_many :comments
  has_many :tags
  has_many :languages
  has_many :categories

  validates :username,
    :presence => true,
    :uniqueness => {:case_sensitive => false},
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

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def require_password?
    self.crypted_password && self.crypted_password_changed?
  end

end