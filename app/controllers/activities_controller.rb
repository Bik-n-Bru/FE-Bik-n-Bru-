class ActivitiesController < ApplicationController

  def create
    
  end

  def show
    @activity = ActivitiesFacade.find_an_activity(params[:activity_id])
  end
end