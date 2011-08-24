#rails generate controller Sessions new
class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate?(params[:session][:email], params[:session][:password])
    if user.nil?
      @title = "Sign in"
      flash.now[:error] = "Invalid email/pass combination"
      render :new
    else
      sign_in user
      if (session[:return_to])
        redirect_to session[:return_to]
        session[:return_to] = nil
      elsif
        redirect_to user_path(@current_user.id)
      end
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
