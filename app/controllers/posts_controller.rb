class PostsController < ApplicationController
  before_filter :check_admin_auth!

  def index
    p current_admin["email"]
    @posts = Post.get_data_from_url
  end

  def new
    p current_admin.email
  end

  def create
    Post.generate_data_from_url("post[title]" => params[:post][:title], "post[content]" => params[:post][:content] )
    redirect_to root_url and return
  end
end
