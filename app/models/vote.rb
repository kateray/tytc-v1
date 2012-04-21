class Vote < ActiveRecord::Base
  belongs_to :link, :counter_cache => true
  belongs_to :user

  validates :user_id,
  	:uniqueness => {:scope => :link_id}
end
