class UsersController < ApplicationController
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
      redirect_to user_path(@user), :flash => { :success => "Welcome to sample app"}
    else
      @title = "Signup error!"
      render :new
    end
  end

end
