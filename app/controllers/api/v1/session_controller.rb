class Api::V1::SessionController < Devise::SessionsController
  #ref: https://gist.github.com/jwo/1255275
  prepend_before_filter :require_no_authentication, :only => [:create ]
  include Devise::Controllers::Helpers

  respond_to :json
  before_filter :ensure_params_exist

  def create
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        resource = Admin.find_for_database_authentication(:email => params[:admin][:email])
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:admin][:password])
          p "xxxxxxxxx"
          resource.ensure_authentication_token!
          render :json => { email: resource.email, :auth_token => resource.authentication_token }, success: true, status: :created
          return
          #render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
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
  end

  protected
  def ensure_params_exist
    return unless params[:admin].blank?
    render :json=>{:success=>false, :message=>"missing admin parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end
