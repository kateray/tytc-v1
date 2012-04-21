class Link < ActiveRecord::Base

  attr_accessor :current_user
  
  belongs_to :user
  belongs_to :tag
  has_many :votes
  has_many :taggings
  has_many :tags, :through => :taggings
  has_many :comments
  
  validates :user_id,
    :presence => true
  validates :url, 
    :presence => true,
    :uniqueness => {:message => "Someone's already added that link"}
  validates :title,
    :presence => true
  
  def as_json(options={})
    result = super({ :except => [:user_id, :created_at, :updated_at] })
    if current_user
      if current_user.votes.where(:link_id => self.id).any?
        result['has_voted'] = 'true'
      else
         result['has_voted'] = 'false'
      end
    else
      result['has_voted'] = 'none'
    end
    result["username"] = user.username
    result["taggings"] = self.taggings.collect{|tagging| tagging.tag.name}
    result
  end

end