class BEService
  def self.conn
    Faraday.new('https://be-bik-n-bru.herokuapp.com')
  end

  def self.login_user(user_input)
    headers_input = {"CONTENT_TYPE" => "application/json"}

    response = conn.post("/api/v1/users") do |req|
      req.headers[:CONTENT_TYPE] = "application/json"
      req.body = JSON.generate(user: user_input)
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end