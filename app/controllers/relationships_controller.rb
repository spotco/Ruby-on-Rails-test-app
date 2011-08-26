class RelationshipsController < ActionController::Base
  include SessionsHelper
   
 
  def create
    #raise params.inspect
    @user = User.find_by_id(User.find_by_id(params[:relationship][:followed_id]))
    current_user.follow!(User.find_by_id(params[:relationship][:followed_id]))
    respond_to do |format|
      format.html {redirect_to user_path(params[:relationship][:followed_id])}
      format.js
    end
  end
  
  def destroy
    tar = Relationship.find_by_id(params[:id])
    @user = User.find_by_id(tar.followed_id)
    tar.destroy
    respond_to do |format|
      format.html {redirect_to user_path(tar.followed_id)}
      format.js 
    end
  end
  
end
