class Api::V1::BaseController < ApplicationController
  # disable the CSRF token
  #protect_from_forgery with: :null_session

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  attr_accessor :current_admin

  # disable cookies (no set-cookies header in response)
  before_action :destroy_session

  # disable the CSRF token
  skip_before_action :verify_authenticity_token


  def destroy_session
    request.session_options[:skip] = true
  end

  def api_error(opts = {})
    render nothing: true, status: opts[:status]
  end

  def unauthenticated!
    api_error(status: 401)
  end

  def authenticate_admin!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    admin_email = options.blank?? nil : options[:email]
    admin = admin_email && Admin.find_by(email: admin_email)

    if admin && ActiveSupport::SecurityUtils.secure_compare(admin.authentication_token, token)
      self.current_admnin = admin
    else
      return unauthenticated!
    end
  end
end
