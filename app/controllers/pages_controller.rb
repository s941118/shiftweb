class PagesController < ApplicationController
	before_action :set_authorization
  def home
  end

  def works
  	authorize :work, :index?
    @works = Work.all#.limit(params[:n])#publish
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
