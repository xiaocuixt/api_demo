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
        resource = Admin.find_for_database_authentication(:email=>params[:admin][:email])
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:admin][:password])
          sign_in("user", resource)
          render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
          return
        end
        invalid_login_attempt
      }
    end
  end

  def destroy
  end

  protected
  def ensure_params_exist
    return unless params[:admin].blank?
    render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end
