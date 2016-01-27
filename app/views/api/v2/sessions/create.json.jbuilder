json.session do
  json.(@user, :id, :email)
  json.token @user.authentication_token
end