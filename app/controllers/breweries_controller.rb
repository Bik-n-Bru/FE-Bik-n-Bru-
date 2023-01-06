class BreweriesController < ApplicationController

  def index
    @user = User.find[params(:user_id)]
    @breweries = BreweryFacade.user_location_breweries(params[:user_id])
  end
end