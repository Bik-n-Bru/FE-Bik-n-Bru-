class ActivitiesController < ApplicationController
  def show
    @activity = ActivitiesFacade.find_an_activity(params[:id])
  end
end