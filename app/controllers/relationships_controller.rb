class RelationshipsController < ActionController::Base
  include SessionsHelper
   
 
  def create
    #raise params.inspect
    current_user.follow!(User.find_by_id(params[:relationship][:followed_id]))
    respond_to do |format|
      format.html {redirect_to user_path(params[:relationship][:followed_id])}
      format.js {}
    end
  end
  
  def destroy
    tar = Relationship.find_by_id(params[:id])
    redirect_to user_path(tar.followed_id)
    tar.destroy
  end
  
end
