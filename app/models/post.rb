class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  #使用Faraday
  def self.get_data_from_url
    conn = Faraday.new(:url => 'http://139.196.38.11:4000/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.response :json
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    response = conn.get do |req|
      req.url "/api/v1/posts"
      req.headers['Content-Type'] = 'application/json'
      req.headers['Accept'] = 'application/json'
    end
    JSON.parse response.body
  end

  def self.generate_data_from_url hash={}
    conn = Faraday.new("http://xiaocuixt.ngrok.cc/")
    conn.post '/api/v1/posts', hash
    redirect_to new_post_url and return
  end
end
