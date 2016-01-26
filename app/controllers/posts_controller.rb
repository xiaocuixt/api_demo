class PostsController < ApplicationController
  respond_to :json

  def index
    @posts = Post.get_data_from_url
  end

  def new
  end

  def create
    Post.generate_data_from_url("post[title]" => params[:post][:title], "post[content]" => params[:post][:content] )
    redirect_to root_url and return
  end
end
