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
  
  def self.find_user_badges(user_id)
    response = conn.get("/api/v1/users/#{user_id}/badges")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.user_activities(user_id)
    response = conn.get("/api/v1/users/#{user_id}/activities")
    JSON.parse(response.body, symbolize_names: true)
  end

  #this is not functional at this time
  def self.create_activity(activity_data)
    response = conn.post("/api/v1/activities") do |req|
      req.headers[:CONTENT_TYPE] = "application/json"
      req.body = JSON.generate(activity: activity_data)
    end
  end 

  def self.find_activity(activity_id)
    response = conn.get("/api/v1/activities/#{activity_id}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
