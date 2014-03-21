# == Schema Information
#
# Table name: votes
#
#  id         :integer          primary key
#  user_id    :integer
#  link_id    :integer
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#

class Vote < ActiveRecord::Base
  belongs_to :link, :counter_cache => true
  belongs_to :user

  validates :user_id,
  	:uniqueness => {:scope => :link_id}
end
