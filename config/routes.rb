Rails.application.routes.draw do
  get '/', to: 'users#login'
  get '/dashboard', to: 'users#show'
  get '/logout', to: "users#logout"

  get '/auth/strava/callback', to: 'sessions#create'

  
end
