class SessionsController < ApplicationController

  def new
  end

  def create
    #conn = Faraday.new("http://139.196.38.11:4000/")
    conn = Faraday.new("http://xiaocuixt.ngrok.cc/")
    response = conn.post '/api/v1/sign_in', { :email => params[:admin][:email], :password => params[:admin][:password] }, {'Accept' => 'application/json'}
    # response_body = JSON.parse(response.body)
    # if response.code == "201"
    #     response_body = JSON.parse(response.body)
    #     session[:auth_token] = response_body["authentication_token"]
    #     session[:current_user_id] = response_body["user_id"]
    # else
    #     # handle errors gracefully
    # end

    redirect_to root_url and return
  end
end
