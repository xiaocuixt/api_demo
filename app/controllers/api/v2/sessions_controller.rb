class Api::V2::SessionsController < Api::V2::BaseController

  api :POST, '/api/v2/sign_in', :email => "用户邮箱", :password => "用户密码", :required => true
  param :email, String, :desc => "登录邮箱", :required => true
  param :password, String, :desc => "登录密码", :required => true

  def create
    @user = User.find_by(email: create_params[:email])
    if @user && @user.authenticate(create_params[:password])
      self.current_user = @user
    else
      return api_error(status: 401)
    end
  end

  before_action :authenticate_user!, only: [:update]

  def update
    @user = User.find(params[:id])
    @user.update_attributes(update_params)
  end

  private

  def create_params
    params.require(:user).permit(:email, :password)
  end

  def update_params
    params.require(:user).permit(:name)
  end
end
