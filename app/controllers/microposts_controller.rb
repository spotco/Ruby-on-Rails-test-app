class MicropostsController < ActionController::Base
  include SessionsHelper
  
  before_filter :authenticate
  before_filter :correct_user, :only => [:destroy]
  
  def create
    @micropost = (current_user).microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "message posted"
      redirect_to root_path
    else
      flash[:error] = "error with your post"
      redirect_to root_path
    end
  end
  
  def destroy
    target = Micropost.find(params[:id])
    target.destroy
    flash[:success] = "post deleted"
    if (session[:return_to])
        redirect_to session[:return_to]
        session[:return_to] = nil
    else
      redirect_to root_path
    end
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = Micropost.find(params[:id]).user
    if !(@user == current_user)
      flash[:error] = "dont edit other ppls stuff pls"
      redirect_to root_path
    end
  end
  
end
