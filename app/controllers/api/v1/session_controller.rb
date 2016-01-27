class Api::V1::SessionController < Devise::SessionsController
  #ref: https://gist.github.com/jwo/1255275
  prepend_before_filter :require_no_authentication, :only => [:create ]
  include Devise::Controllers::Helpers

  respond_to :json
  def create
    # self.resource = warden.authenticate!(auth_options)
    # set_flash_message(:notice, :signed_in) if is_flashing_format?
    # sign_in(resource_name, resource)
    # yield resource if block_given?
    # respond_with resource, location: after_sign_in_path_for(resource)
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        resource = Admin.find_for_database_authentication(:email => params[:email])
        return invalid_login_attempt unless resource
        if resource.valid_password?(params[:password])
          #resource.ensure_authentication_token!
          render :json => { :email => resource.email, :authentication_token => resource.authentication_token }, success: true, status: :created
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

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end
