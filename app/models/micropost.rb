#bundle exec annotate
class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user

  default_scope :order => "microposts.created_at DESC"
  
  validates :content, :presence => true,
                      :length => { :maximum => 140 }
                      
  validates :user_id, :presence => true
end

# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

