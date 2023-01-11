Rails.application.routes.draw do
  get '/', to: 'users#login'
  get '/dashboard', to: 'users#show'
  get '/logout', to: "users#logout"
  patch '/update', to: 'users#update'

  patch "/dashboard", to: "users#update"

  get '/auth/strava/callback', to: 'sessions#create'

  resources :breweries, only: [:index]
  resources :activities, only: [:show, :create]
end
