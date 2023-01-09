class BreweriesController < ApplicationController

  def index
    # @user = UsersFacade.user_detail(session[:user_id])
    @breweries = BreweryFacade.user_location_breweries(session[:user_id])
  end
end