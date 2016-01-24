class Post < ActiveRecord::Base
  #使用Faraday
  def self.get_data_from_url
    conn = Faraday.new(:url => 'http://139.196.38.11:4000/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    response = conn.get do |req|
      req.url "/api/v1/posts"
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
    end
    MultiJson.load response.body
  end
end
