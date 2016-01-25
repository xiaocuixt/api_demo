class SessionsController < ApplicationController

  def new
  end

  def create
    conn = Faraday.new("http://localhost:3000/")
    begin
      conn.post '/api/v1/sessions', { :email => params[:admin][:email], :password => params[:admin][:password] },{ 'X-Accept' => 'application/json' }
    rescue Exception => e
      flash[:error] = "创建失败"
    end
    redirect_to new_post_path
  end
end
