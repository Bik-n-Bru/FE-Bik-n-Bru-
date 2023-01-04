Rails.application.routes.draw do
  get '/', to: 'users#login'
  # get '/register/free', to: "https://www.strava.com/register/free"

end
