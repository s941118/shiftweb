class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  # GET /posts
  def index
    @posts = Post.all
    authorize @posts
  end

  # GET /posts/1
  def show
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    	authorize @post
    end
end
