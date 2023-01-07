class BEService
  def self.conn
    Faraday.new('https://be-bik-n-bru.herokuapp.com')
  end

  def self.login_user(user_input)
    response = conn.post("/api/v1/users") do |req|
      req.headers[:CONTENT_TYPE] = "application/json"
      req.body = JSON.generate(user: user_input)
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.leaderboard
    response = conn.get("/api/v1/leaderboard")
    JSON.parse(response.body, symbolize_names: true)
  end

  # def self.location_update(city, state, user_id)
  #   response = conn.patch("/api/v1/users") do |req|
  #     binding.pry
  #     req.headers[:CONTENT_TYPE] = "application/json"
  #     req.body = JSON.generate(city: city, state: state, user_id: user_id)
  #   end
  #   JSON.parse(response.body, symbolize_names: true)
  # end
end