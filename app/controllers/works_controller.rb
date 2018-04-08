class WorksController < ApplicationController
  before_action :set_work, only: [:show]

  # GET /works
  def index
    @works = Work.all
    authorize @works
  end

  # GET /works/1
  def show
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.find(params[:id])
    	authorize @work
    end
end
