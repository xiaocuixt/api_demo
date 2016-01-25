class Api::V1::AdminsController < Api::V1::BaseController
  respond_to :json
  api :GET, '/admins'
  def index
    @admins = Admin.all
    respond_with @admins
  end
end