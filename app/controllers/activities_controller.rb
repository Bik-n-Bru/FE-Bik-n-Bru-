class ActivitiesController < ApplicationController

  def show
    last_user_activity = @user.activity.last
    @activity = ActivityFacade.find_activity(last_user_activity.id)
  end
end