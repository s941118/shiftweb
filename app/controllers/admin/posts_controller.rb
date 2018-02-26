class Admin::PostsController < AdminController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    authorize [:admin, @posts]
  end

  # GET /posts/1
  # GET /posts/1.json
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
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    authorize [:admin, @post]
    respond_to do |format|
      if @post.save
        @post.contents.create(ordering: 1, html: "<p/>")
        format.html { redirect_to edit_admin_post_path(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        puts @post.contents.pluck(:id, :ordering)
        @post.touch
        format.html { redirect_to [:admin, @post], notice: 'post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render [:admin, :edit] }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      authorize [:admin, @post]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, contents_attributes: [ :id, :html, :ordering, :_destroy, :wrapper_klass ])
    end
end