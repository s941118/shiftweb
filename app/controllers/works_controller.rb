class WorksController < ApplicationController
  before_action :set_work, only: [:show]

  # GET /works/1
  def show
    @contents = Content.where(work_id: params[:id]).order(ordering: :asc).with_attached_image
    unless params[:js] == "true"
      @works = Work.publish.order(work_date: :desc)
      render "pages/works"
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    	authorize @work
    end
end
