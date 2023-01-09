class StravaService
  def self.conn
    Faraday.new(url: 'https://www.strava.com', headers: {'Accept': 'application/json'})
  end

  def self.authorize_user_account(code)
    response = conn.post('/api/v3/oauth/token') do |req|
      req.params['client_id'] = ENV['strava_client_id']
      req.params['client_secret'] = ENV['strava_client_secret']
      req.params['code'] = code
      req.params['grant_type'] = 'authorization_code'
      req.params['scope'] = 'read'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  

end