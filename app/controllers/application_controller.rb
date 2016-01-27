class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  helper_method :current_admin

  def current_admin
    @current_admin ||= session[:current_admin]
  end

  def admin_signed_in?
    current_admin.present?
  end

  def check_admin_auth!
    unless admin_signed_in?
      redirect_to new_session_url
    end
  end
end
