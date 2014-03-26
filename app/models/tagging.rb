# == Schema Information
#
# Table name: taggings
#
#  id         :integer          primary key
#  link_id    :integer
#  tag_id     :integer
#  user_id    :integer
#  created_at :timestamp        not null
#  updated_at :timestamp        not null
#

class Tagging < ActiveRecord::Base

  attr_accessor :tag_name

  belongs_to :user
  belongs_to :link
  belongs_to :tag

  # validates :link_id,
  #   :presence => true
  # validates :tag_id,
  #   :presence => true

  after_create :increment_parent_counter_cache
  after_destroy :decrement_parent_counter_cache

  private

  def increment_parent_counter_cache
    self.tag.class.increment_counter(:links_count, self.tag_id)
  end

  def decrement_parent_counter_cache
    self.tag.class.decrement_counter(:links_count, self.tag_id)
  end

end
