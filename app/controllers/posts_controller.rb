class PostsController < ApplicationController

  def index
    @posts = Post.get_data_from_url
  end

  def new
  end

  def create
    conn = Faraday.new("http://localhost:3000")
    begin
      conn.post '/api/v1/posts', { :title => params[:post][:title], :content => params[:post][:content] },{ 'X-Accept' => 'application/json' }
    rescue Exception => e
      flash[:error] = "创建失败"
    end
    redirect_to new_post_path
  end
end
