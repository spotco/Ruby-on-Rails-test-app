class PagesController < ApplicationController
  include SessionsHelper

  def home
    @title = "Accueil"
    @micropost = Micropost.new if signed_in?
    @user = current_user
  end

  def contact
  	@title = "Contacter"
  end
  
  def about
  	@title = "A Propos De"
  end
  
  def help
  	@title = "Aide"
  end

end
