class Api::V2::UsersController < Api::V2::BaseController

  before_action :authenticate_user!, only: [:update]
  
  api :PUT, '/api/v2/user', "更新user"
  param :id, :number
  def update
    @user = User.find(params[:id])
    @user.update_attributes(update_params)
  end

  private

  def update_params
    params.require(:user).permit(:name)
  end

end