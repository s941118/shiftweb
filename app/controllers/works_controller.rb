class WorksController < ApplicationController
  before_action :set_work, only: [:show]

  # GET /works
  def index
    authorize @works
    @works = Work.all
  end

  # GET /works/1
  def show
    @contents = Content.where(work_id: params[:id]).order(ordering: :asc)
    unless params[:js] == "true"
      @works = Work.all
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
