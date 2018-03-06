class Admin::ContentsController < AdminController
  # POST /contents
  def create
    @post = Post.find(params[:post_id])
    @content = @post.contents.new(html: "<p></p>", image: params[:file], usage: "img", ordering: params[:ordering] || "9999")
    authorize [:admin, @content]

    if @content.save
      flash[:success] = "建立成功。"
      render json: { content_id: @content.id ,image_url: rails_blob_path(@content.image), content_html: @content.html }, status: :ok
    else
      p @content.errors
      render :new
    end
  end

  # PATCH/PUT /contents/1
  def update
    if @content.update(content_params)
      flash[:success] = "更新成功。"
      redirect_to [:admin, @content]
    else
      render :edit
    end
  end

  # DELETE /contents/1
  def destroy
    @content.destroy
    flash[:success] = "刪除成功。"
    redirect_to admin_contents_url
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    	authorize [:admin, @content]
    end

    # Only allow a trusted parameter "white list" through.
    def content_params
      params.require(:content).permit(:html, :ordering, :usage, :_destroy, :wrapper_klass, :image)
    end
end