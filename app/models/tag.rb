class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :links, :through => :taggings

  validates :name, 
  :presence => true,
  :uniqueness => {:message => "Tag already exists"}
end