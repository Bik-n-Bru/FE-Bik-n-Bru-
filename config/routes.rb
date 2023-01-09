Rails.application.routes.draw do
  get '/', to: 'users#login'
  get '/dashboard', to: 'users#show'
  get '/logout', to: "users#logout"
  patch '/update', to: 'users#update'

  patch "/dashboard", to: "users#update"

  get "/breweries", to: "breweries#index"

  get '/auth/strava/callback', to: 'sessions#create'

  get "/activities/:activity_id", to: "activities#show"
end
