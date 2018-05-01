class PagesController < ApplicationController
	before_action :set_authorization
  def home
    @latest_works = Work.order(work_date: :desc).limit(3)
  end

  def works
  	authorize :work, :index?
    @works = if params[:tag].present? && Tag.find_by_name(params[:tag]).present?
      Work.tagged_with(params[:tag])
    else
      Work.all
    end.publish.order(work_date: :desc)
  end

  def about
    
  end

  def members
    @members = Tag.member.with_attached_icon.with_attached_member_bg
  end

  private

  def set_authorization
  	skip_authorization
  end
end
