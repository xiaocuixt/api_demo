class Api::V1::PostsController < Api::V1::BaseController

  def index
    @posts = Post.all
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Post创建成功"
    else
      flash[:error] = "Post创建失败"
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
