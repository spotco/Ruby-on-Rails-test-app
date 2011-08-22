module SessionsHelper
  #cookies[:remember_token] = {:value => "lol"}
  
  
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    @current_user = user
  end
  
  #def current_user=(user)
  #    @current_user = user
  #  end
  
  def current_user
    @current_user ||= user_from_remember_token
    
    #@current_user = @current_user || user_from_remember_token
  end
  
  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
    #breaks [0,1] array into (0,1) as two args
  end
  
  def remember_token
    cookies.signed[:remember_token] || [nil,nil]
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
  end
  
end
