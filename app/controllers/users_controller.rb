class UsersController < ApplicationController
  def new
	@title = "Enregister"
  end
  
  def show
	@user = User.find(params[:id])
  end

end
