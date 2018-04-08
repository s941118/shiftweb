class PagesController < ApplicationController
	before_action :set_authorization
  def home
  end

  def works
  	
  end

  def about
    
  end

  def members
    
  end

  private

  def set_authorization
  	skip_authorization
  end
end
