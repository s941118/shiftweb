class Admin::TagsController < AdminController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  # GET /tags
  def index
    authorize [:admin, :tag], :index?
    @search_param = :name_cont
    @q = Tag.ransack(params[:q])
    tags = @q.result(distinct: true)
    @tags = tags.order(updated_at: :desc)
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
      if ActiveModel::Type::Boolean.new.cast tag_params[:remove_icon]
        @tag.icon.purge_later
      end
      if ActiveModel::Type::Boolean.new.cast tag_params[:remove_member_bg]
        @tag.member_bg.purge_later
      end
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
      params.require(:tag).permit(:name, :category, :icon, :remove_icon, :member_bg, :remove_member_bg)
    end
end