# == Schema Information
#
# Table name: tags
#
#  id          :integer          primary key
#  name        :string(255)
#  group       :string(255)
#  links_count :integer          default(0)
#  user_id     :integer
#  created_at  :timestamp        not null
#  updated_at  :timestamp        not null
#

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :links, :through => :taggings

  validates :name, 
  :presence => true,
  :uniqueness => {:message => "Tag already exists"}

  def time
  	self.created_at.to_i
  end
end
