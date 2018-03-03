class PagesController < ApplicationController
	before_action :set_authorization
  def home
  end

  def test
  	
  end

  private

  def set_authorization
  	skip_authorization
  end
end
