class Api::V1::PostsController < Api::V1::BaseController
  respond_to :json

  def index
    @posts = Post.all
    respond_with @posts
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Post创建成功"
      respond_with @post, location: url_for([:api, :v1, @post])
    else
      flash[:error] = "Post创建失败"
      respond_with @post, location: url_for([:api, :v1, @post])
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
