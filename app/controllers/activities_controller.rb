class ActivitiesController < ApplicationController

  def create
    
  end

  def show
    binding.pry
    # last_user_activity = @user.activity.last
    @activity = ActivityFacade.find_activity(last_user_activity.id)
  end
end