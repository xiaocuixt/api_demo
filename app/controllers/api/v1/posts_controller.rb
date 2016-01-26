class Api::V1::PostsController < Api::V1::BaseController
  #acts_as_token_authentication_handler_for Admin
  respond_to :json

  def index
    respond_with @posts = Post.all
  end

  def new
    respond_with @book = Post.new
  end

  def create
    respond_with @post = Post.create(post_params)
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
