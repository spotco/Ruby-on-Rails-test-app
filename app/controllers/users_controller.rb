class UsersController < ApplicationController
  include SessionsHelper
  
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
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
  
  def edit
    @user = User.find(params[:id])
    @title = "Editing #{@user.name}"
  end
  
  def update
    @user = User.find(params[:id])
    if !@user.update_attributes(params[:user])
      flash.now[:error] = "Invalid user info, update failed"
      @title = "Update Failure :("
      @user = User.find(params[:id])
      render :edit
    else 
      redirect_to @user
      flash[:success] = "Ça marche"
    end
  end
  
  def index
    @title = "Tout les mains REPORT"
    @users = User.paginate(:page => params[:page],:per_page => 10)
  end


private
  
  def authenticate
    loggedin_user = current_user
    if (!signed_in?)
      deny_access()
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    if !(@user == current_user)
      flash[:error] = "dont edit other ppls stuff pls"
      redirect_to root_path
    end
  end

end
