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