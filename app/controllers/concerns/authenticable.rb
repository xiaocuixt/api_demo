module Authenticable
  # Devise methods overwrites
  def current_admin
    @current_admin ||= Admin.find_by(auth_token: request.headers['X-Admin-Token'])
  end
end