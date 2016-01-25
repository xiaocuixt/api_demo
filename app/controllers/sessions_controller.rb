class SessionsController < ApplicationController

  def new
  end

  def create
    conn = Faraday.new("http://127.0.0.1:3000/")
    response = conn.post '/api/v1/sign_in', { :email => params[:admin][:email], :password => params[:admin][:password] },{ 'X-Accept' => 'application/json' }
  end
end
