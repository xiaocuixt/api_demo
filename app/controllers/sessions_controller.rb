class SessionsController < ApplicationController

  def new
  end

  def create
    conn = Faraday.new("http://139.196.38.11:4000/")
    #conn = Faraday.new("http://xiaocuixt.ngrok.cc/")
    response = conn.post '/api/v1/sign_in', { :email => params[:admin][:email], :password => params[:admin][:password] }, {'Accept' => 'application/json'}
    response_body = JSON.parse(response.body)
    session[:authentication_token] = response_body["authentication_token"]
    session[:current_admin] = response_body["current_admin"]

    p response_body = JSON.parse(response.body)
    p session[:authentication_token] = response_body["authentication_token"]
    p session[:current_admin] = response_body["current_admin"]
    redirect_to root_url and return
  end
end
