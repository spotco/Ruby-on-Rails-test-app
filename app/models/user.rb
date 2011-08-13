class User < ActiveRecord::Base
	attr_accessible :name, :email
	
	email_regex = /^[\w]+[@]{1}[\w]+[.]{1}[\w]+$/
	
	validates( :name,  :presence => true,
					   :length => { :maximum => 4 } )
					  
	validates( :email, :presence => true,
					   :format => {:with => email_regex },
					   :uniqueness => { :case_sensitive => false})
end

#user.errors.full_messages

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

