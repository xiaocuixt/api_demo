class PostsController < ApplicationController
  respond_to :json

  def index
    @posts = Post.get_data_from_url
  end

  def new
  end

  def create
    conn = Faraday.new("http://139.196.38.11:4000/")
    begin
      conn.post '/api/v1/posts', { :title => params[:post][:title], :content => params[:post][:content] },{ 'X-Accept' => 'application/json' }
      redirect_to new_post_path
    rescue Exception => e
      puts "#{e.message}"
    end
  end
end
