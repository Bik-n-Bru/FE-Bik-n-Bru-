class ActivitiesController < ApplicationController

  def create
    serialized_activity = ActivitySerializer.serialize_activity(params[:brewery_name],params[:drink_type], params[:user_id])
    unformatted_activity = BEService.create_activity(serialized_activity)
    activity = Activity.new(unformatted_activity[:data])
    params[:activity_id] = activity.id
    redirect_to "/activities/#{activity.id}"
  end

  def show
    @activity = ActivitiesFacade.find_an_activity(params[:id])
  end
end