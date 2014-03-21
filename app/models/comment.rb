# == Schema Information
#
# Table name: comments
#
#  id         :integer          primary key
#  user_id    :integer
#  link_id    :integer
#  content    :text
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :link, :counter_cache => true

  def username
  	user.username
  end

  def time
  	if created_at.to_date == Date.today
  		created_at.strftime('%l:%M %p')
  	else
  		created_at.strftime('%-m-%-d-%y')
  	end
  end
end
