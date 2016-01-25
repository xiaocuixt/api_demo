json.session do
  json.(@admin, :id, :email)
  json.token @admin.authentication_token
end