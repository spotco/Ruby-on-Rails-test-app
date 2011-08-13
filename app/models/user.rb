class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation, :salt
	
	email_regex = /^[\w]+[@]{1}[\w]+[.]{1}[\w]+$/
	
	validates  :name,  :presence => true,
					           :length => { :maximum => 20 } 
					   
	validates  :email, :presence => true,
					           :format => {:with => email_regex },
					           :uniqueness => { :case_sensitive => false}
					   
	validates  :password, :presence => true,
	                      :confirmation => true,
	                      :length => { :within => 6..40 }
	                      
	validates :password_confirmation, :presence => true
	                      
	                      
	                      
  before_save :encrypt_password
  
  def self.authenticate?(email,pass)
    user = User.find_by_email(email)
    
    return nil if user.nil?
    return user if user.has_password?(pass)
  end
  
  def has_password?(submitted_password)
     self.encrypted_password == encrypt(submitted_password) 
  end
  
  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(self.password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def secure_hash(str)
      Digest::SHA2.hexdigest(str)
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
	                     
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

