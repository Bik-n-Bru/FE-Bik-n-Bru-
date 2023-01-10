class BreweriesController < ApplicationController

  def index
    @breweries = BreweryFacade.user_location_breweries(@user.id)
  end
end