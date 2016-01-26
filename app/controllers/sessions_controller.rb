class SessionsController < ApplicationController

  def new
  end

  def create
    #conn = Faraday.new("http://139.196.38.11:4000/")
    conn = Faraday.new("http://xiaocuixt.ngrok.cc/")
    response = conn.post '/api/v1/sign_in', { :email => params[:admin][:email], :password => params[:admin][:password] }
    if response.code == "201"
      response_body = JSON.parse(response.body)
      session[:auth_token] = response_body["authentication_token"]
      session[:current_admin_id] = response_body["admin_id"]
    else
      handle errors gracefully
    end
    redirect_to new_post_url and return
  end
end
