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
  
  def self.find_user(user_id)
    response = conn.get("/api/v1/users/#{user_id}")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.update_user(user_id, serialized_data)
    response = conn.patch("/api/v1/users/#{user_id}") do |req|
      req.headers[:CONTENT_TYPE] = "application/json"
      req.body = JSON.generate(user: serialized_data)
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.breweries_by_user_location(user_id)
    response = conn.get("/api/v1/breweries/#{user_id}")
    JSON.parse(response.body, symbolize_names: true)
  end 

  def self.create_activity(activity_data)
    response = conn.post("/api/v1/activities") do |req|
      req.headers[:CONTENT_TYPE] = "application/json"
      req.body = JSON.generate(activity: activity_data)
      binding.pry
    end
  end
  
  # def self.user_activities(user_id)
  #   response = conn.get("/api/v1/users/#{user_id}/activities")
  #   JSON.parse(response.body, symbolize_names: true)
  # end

  def self.find_activity(activity_id)
    response = conn.get("/api/v1/activities/#{activity_id}")
    JSON.parse(response.body, symbolize_names: true)
  end
end

#data response from service for finding an activity
# "{\"data\":{\"id\":\"666\",\"type\":\"activity\",\"attributes\":{\"brewery_name\":\"Joelle Becker\",\"distance\":72.13,\"calories\":368,\"num_drinks\":0,\"drink_type\":\"Chimay Grande Réserve\",\"dollars_saved\":82.44,\"lbs_carbon_saved\":36.0,\"user_id\":76},\"relationships\":{\"user\":{\"data\":{\"id\":\"76\",\"type\":\"user\"}}}}}"