class Relationship < ActiveRecord::Base
  attr_accessible :followed_id
  
  #assumes belongs to :follower, specify otherise
  belongs_to :follower, :foreign_key => "follower_id", :class_name => "User"
  belongs_to :followed, :foreign_key => "followed_id", :class_name => "User"
  
  validates :follower_id, :presence => true
  validates :followed_id, :presence => true
  
  #validates pairs
  validates_uniqueness_of :follower_id, :scope => [:followed_id]
  
end

# == Schema Information
#
# Table name: relationships
#
#  id          :integer         not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

