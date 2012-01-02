class PagesController < ApplicationController
  def home
  @title = "home"
  end

  def contact
  @title = "contact"
  end

  def feedback
  @title = "feedback"
  end

  def privacy
  @title = "privacy"
  end

  def terms
  @title = "terms & conditions"
  end
  
  def help
  @title = "Help"
  end

end
