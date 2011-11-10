class PagesController < ApplicationController

  # Common to all actions
  #def initialize
	#@title = "Home"	
  #end
  
  def home
	@title = "Home"
  end

  def contact
	@title = "Contact"
  end

  def about
	@title = "About"
  end
  
  def help
    @title = "Help"
  end
  
end
