Rails.application.routes.draw do
  get '/', to: 'users#login'
  
  get '/auth/strava/callback', to: 'sessions#create'
end
