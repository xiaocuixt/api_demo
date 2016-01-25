class Api::V1::UsersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Admin

  api :GET, '/users/:id'
  param :id, :number

  def show
    @user = User.find(params[:id])
  end

  api :PUT, '/users'
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
