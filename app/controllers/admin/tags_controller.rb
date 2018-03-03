class Admin::TagsController < AdminController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  def index
    @tags = Tag.all.order(updated_at: :desc)
    authorize [:admin, @tags]
  end

  # GET /tags/1
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
    authorize [:admin, @tag]
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)
    authorize [:admin, @tag]

    if @tag.save
      flash[:success] = "建立成功。 "
      redirect_to [:admin, @tag]
    else
      render :new
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      flash[:success] = "更新成功。 "
      redirect_to [:admin, @tag]
    else
      render :edit
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    flash[:success] = "刪除成功。 "
    redirect_to admin_tags_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    	authorize [:admin, @tag]
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:name)
    end
end