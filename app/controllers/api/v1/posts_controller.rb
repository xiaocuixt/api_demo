class Api::V1::PostsController < Api::V1::BaseController
  #acts_as_token_authentication_handler_for Admin
  respond_to :json, :html

  def index
    respond_with @posts = Post.all
  end

  def new
    respond_with @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.save
    respond_with :api, :v1, @post
  end

  def show
    @post = Post.find(params[:id])
    respond_with @post
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
