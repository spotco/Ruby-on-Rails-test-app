class UsersController < ApplicationController
  include SessionsHelper
  
  def new
	 @title = "Enregister"
	 @user = User.new
  end
  
  def show
	 @user = User.find(params[:id])
	 @title = @user.name
  end
  
  def create
    #raise params[:user].inspect
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to sample app!"
      redirect_to user_path(@user.id)
    else
      @title = "Erreur avec votre info de compte"
      render :new
    end
  end

end
