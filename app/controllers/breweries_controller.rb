class BreweriesController < ApplicationController
  # before_action :require_user

  def index
    binding.pry
    # @user = User.find[params(:user_id)]

    @breweries = BreweryFacade.user_location_breweries(params[:user_id])
  end

  # private
  #   def require_user
  #     render file: "/public/404" unless current_user?
  #   end
end