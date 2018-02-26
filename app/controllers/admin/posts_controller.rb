class Admin::PostsController < AdminController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all.order(updated_at: :desc)
    authorize [:admin, @posts]
  end

  # GET /posts/1
  def show
    @contents = Content.where(post_id: params[:id]).order(ordering: :asc)#.pluck(:html).join("")
  end

  # GET /posts/new
  def new
    @post = Post.new
    authorize [:admin, @post]
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    authorize [:admin, @post]

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
      @post.touch
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

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    	authorize [:admin, @post]
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, contents_attributes: [ :id, :html, :ordering, :_destroy, :wrapper_klass ])
    end
end