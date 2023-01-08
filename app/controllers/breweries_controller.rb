class BreweriesController < ApplicationController

  def index
    #will refactor to use memoization when Rich merges his branch.
    # @open_struct = OpenStruct.new(user, breweries)
    user = UsersFacade.user_detail(session[:user_id])
    breweries = BreweryFacade.user_location_breweries(session[:user_id])
  end
end