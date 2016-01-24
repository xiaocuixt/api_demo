class Post < ActiveRecord::Base
  #使用Faraday
  def self.get_data_from_url
    conn = Faraday.new do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    response = conn.get "http://61.152.122.112:8080/api/v1/weather_forecasts/query?appid=3z9SIrelF7oKLUbVcPa2&appkey=HYC40csnPN3lMbjf7FiSZIKXTu6AUy&city_name=上海"
    #   req.url "/api/v1/posts"
    #   req.headers['Content-Type'] = 'application/json'
    #   req.headers['Accept'] = 'application/json'
    # end
    MultiJson.load response.body
  end

  def self.get_data
    response = RestClient.get 'http://localhost:3000/api/v1/posts'
    MultiJson.load response.body
  end
end
