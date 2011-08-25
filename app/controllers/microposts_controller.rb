class MicropostsController < ActionController::Base
  include SessionsHelper
  
  before_filter :authenticate
  
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
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
end
