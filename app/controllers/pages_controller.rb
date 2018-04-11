class PagesController < ApplicationController
	before_action :set_authorization
  def home
  end

  def works
  	authorize :work, :index?
    @works = if params[:tag].present? && Tag.find_by_name(params[:tag]).present?
      Work.tagged_with(params[:tag])
    else
      Work.all
    end.publish.order(work_date: :asc)
  end

  def about
    
  end

  def members
    @members = Tag.member
  end

  private

  def set_authorization
  	skip_authorization
  end
end
