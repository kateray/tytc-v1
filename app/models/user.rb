class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_email_field = false
    c.validate_login_field = false
    c.login_field = :username
    # c.find_by_login_method :find_by_email
    # c.validate_password_field = {:if => :require_password?}
    c.require_password_confirmation = {:if => :require_password?}
    # c.merge_validates_length_of_password_field_options :allow_nil => true
  end
  
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