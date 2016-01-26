class SessionsController < ApplicationController

  def new
  end

  def create
    conn = Faraday.new("http://139.196.38.11:4000/")
    response = conn.post '/api/v1/sign_in', { :email => params[:admin][:email], :password => params[:admin][:password] },{ 'X-Accept' => 'application/json' }
    p "fffff"
  end
end
