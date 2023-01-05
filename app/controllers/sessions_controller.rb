class SessionsController < ApplicationController
  def create
    conn = Faraday.new(url: 'https://www.strava.com', headers: {'Accept': 'application/json'})

    response = conn.post('/api/v3/oauth/token') do |req|
      req.params['client_id'] = ENV['strava_client_id']
      req.params['client_secret'] = ENV['strava_client_secret']
      req.params['code'] = params[:code]
      req.params['grant_type'] = 'authorization_code'
    end
    user_data = JSON.parse(response.body, symbolize_names: true)
    serialized_user_data = StravaAuthSerializer.serialize(user_data)

    user_parsed_json = BEService.login_user(serialized_user_data)

    @user = User.new(user_parsed_json)
    session[:user_id] = @user.id
    redirect_to '/dashboard'
  end
end