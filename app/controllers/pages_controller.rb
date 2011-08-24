class PagesController < ApplicationController
	

  def home
	@title = "Accueil"
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
