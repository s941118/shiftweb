class Admin::PostsController < AdminController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :draft]
  layout 'edit_post', only: [:show, :edit, :update]

  # GET /posts
  def index
    @search_param = :title_or_tags_name_or_contents_processed_html_cont
    @q = Post.ransack(params[:q])
    posts = @q.result(distinct: true)
    @posts = if params[:tag].present?
      posts.tagged_with(params[:tag]).order(updated_at: :desc)
    else
      posts.order(updated_at: :desc)
    end
    authorize @posts
  end

  # GET /posts/1
  def show
    @contents = Content.where(post_id: params[:id]).order(ordering: :asc)#.pluck(:html).join("")
  end

  # GET /posts/new
  def new
    @post = Post.new
    authorize @post
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    authorize @post

    if @post.save
      @post.contents.create(ordering: 1, html: "<p/>")
      flash[:success] = "建立成功。 "
      redirect_to edit_admin_post_path(@post)
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      @post.update_tags!
      if ActiveModel::Type::Boolean.new.cast post_params[:remove_cover]
        @post.cover.purge_later
      end
      # @post.touch # 因為 ordering 不再是相對加一，而是每次更新，所以好像不需要順過了？
      flash[:success] = "更新成功。 "
      redirect_to [:admin, @post]
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    flash[:success] = "刪除成功。 "
    redirect_to admin_posts_url
  end

  def publish
    @post.publish! if @post.draft?
    flash[:success] = "作品已公開。"
    redirect_to admin_posts_url
  end

  def draft
    @post.draft! if @post.publish?
    flash[:success] = "作品已撤下轉為草稿。"
    redirect_to admin_posts_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    	authorize @post
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :cover, :remove_cover, :category, :top_tags, :number, contents_attributes: [ :id, :html, :ordering, :usage, :_destroy, :wrapper_klass ])
    end
end