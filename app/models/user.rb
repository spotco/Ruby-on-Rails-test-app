class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :name, :email
	
	email_regex = /^[\w]+[@]{1}[\w]+[.]{1}[\w]+$/
	
	validates  :name,  :presence => true,
					   :length => { :maximum => 20 } 
					   
	validates  :email, :presence => true,
					   :format => {:with => email_regex },
					   :uniqueness => { :case_sensitive => false}
					   
	validates  :password, :presence => true,
	                      :confirmation => true,
	                      :length => { :within => 6..40 }
	                     
end

#user.errors.full_messages


# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#

