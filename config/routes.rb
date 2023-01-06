Rails.application.routes.draw do
  get '/', to: 'users#login'
  get '/logout', to: "users#logout"

  get '/auth/strava/callback', to: 'sessions#create'

  get '/dashboard', to: 'dashboard#index'
end
