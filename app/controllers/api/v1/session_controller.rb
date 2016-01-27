class Api::V1::SessionController < Devise::SessionsController
  #ref: https://gist.github.com/jwo/1255275
  prepend_before_filter :require_no_authentication, :only => [:create ]
  include Devise::Controllers::Helpers

  acts_as_token_authentication_handler_for Admin

  respond_to :json

  api :POST, '/api/v1/sign_in', :email => "用户邮箱", :password => "用户密码", :required => true
  param :email, String, :desc => "登录邮箱", :required => true
  param :password, String, :desc => "登录密码", :required => true

  def create
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        resource = Admin.find_for_database_authentication(:email => params[:email])
        return invalid_login_attempt unless resource
        if resource.valid_password?(params[:password])
          sign_in("admin", resource)
          render :json => { :current_admin => current_admin, :email => resource.email, :authentication_token => resource.authentication_token }, success: true, status: :created
        else
          invalid_login_attempt
        end
      }
    end
  end

  # def sign_in(user)
  #   header('Authorization', "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\"")
  # end

  #http://soryy.com/blog/2014/apis-with-devise/

  #curl -i -X POST -d "admin[email]=cjw624923@126.com&admin[password]=12345678" http://localhost:3000/api/v1/sign_in

  def destroy
    sign_out(resource_name)
  end

  protected

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end
