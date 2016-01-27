class Api::V1::UsersController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for Admin

  api :GET, '/api/v1/users/:id', "用户详情页面"
  param :user, Hash do
    param :id, :number, "用户ID"
    param :email, String, "用户email"
    param :password, String, "用户password"
  end

  def show
    @user = User.find(params[:id])
  end

  api :PUT, '/api/v1/user', :id => "用户ID", :required => true
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
