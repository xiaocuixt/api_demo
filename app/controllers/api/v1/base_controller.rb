class Api::V1::BaseController < ApplicationController
  # disable the CSRF token
  #protect_from_forgery with: :null_session

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  # disable the CSRF token
  skip_before_action :verify_authenticity_token
end
