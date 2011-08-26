
class User < ActiveRecord::Base
	attr_accessor :password, :admin
	attr_accessible :name, :email, :password, :password_confirmation, :salt
	
	#delete post when user deleted
	has_many :microposts, :dependent => :destroy
	
	#specify foreign key
	has_many :relationships, :dependent => :destroy,
	                         :foreign_key => "follower_id"
	#enables access to list of all this is following, through :relationships and the target is followed                     
	has_many :following, :through => :relationships, :source => :followed
	
	#hack for easy followers finding
	has_many :reverse_relationships, :dependent => :destroy,
	                                 :foreign_key => "followed_id",
	                                 :class_name => "Relationship"
	has_many :followers, :through => :reverse_relationships, :source => :follower
	
	
	email_regex = /^[\w]+[@]{1}[\w]+[.]{1}[\w]+$/
	
	validates  :name,  :presence => true,
					           :length => { :maximum => 50 } 
					   
	validates  :email, :presence => true,
					           :format => {:with => email_regex },
					           :uniqueness => { :case_sensitive => false}
					   
	validates  :password, :presence => true,
	                      :confirmation => true,
	                      :length => { :within => 6..40 }
	                      
	validates :password_confirmation, :presence => true
	                      
	                      
	#runs code to generate and store salt, see users_controller     
  before_save :encrypt_password

  #inefficent way to do it
  def getFollowers
    temp = []
    Relationship.find_each(:conditions => ['followed_id = ?', self.id]) do |r|
      temp.push(User.find_by_id(r.follower_id))
    end
    return temp
  end
  
  
  def feed
    #self.microposts
    Micropost
    #Micropost.where("user_id = ?", self.id)
  end
  
  def following?(followed)
    if self.relationships.find_by_followed_id(followed.id)
      return true
    else
      return false
    end
  end
  
  def follow!(followed)
    self.relationships.create!( :followed_id => followed.id )
  end
  
  def unfollow!(followed)
    tar = self.relationships.find_by_followed_id(followed.id)
    if tar
      tar.destroy
      return true
    else
      return false
    end
  end
  
  def self.authenticate?(email,pass)
    user = User.find_by_email(email)
    
    (user && user.has_password?(pass)) ? user : nil
    #return nil if user.nil?
    #return user if user.has_password?(pass)
  end
  
  def self.authenticate_with_salt(id,cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  def has_password?(submitted_password)
     self.encrypted_password == encrypt(submitted_password) 
  end
  
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
#  salt               :string(255)
#  admin              :boolean         default(FALSE)
#

