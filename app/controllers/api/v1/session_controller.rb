class Api::V1::SessionController < Devise::SessionsController
  #ref: https://gist.github.com/jwo/1255275
  prepend_before_filter :require_no_authentication, :only => [:create ]
  include Devise::Controllers::Helpers

  acts_as_token_authentication_handler_for Admin

  respond_to :json

  api :POST, '/api/v1/sign_in', "用户登录"
  def create
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        sign_out(resource_name) if current_admin
        resource = Admin.find_for_database_authentication(:email => params[:admin][:email])
        return invalid_login_attempt unless resource
        if resource.valid_password?(params[:admin][:password])
          sign_in("admin", resource)
          render :json => {:success=>true, :current_admin => resource, :email => resource.email, :authentication_token => resource.authentication_token }, success: true, status: :created
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
    render :json => {:sign_out=>true}
  end

  protected

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end
