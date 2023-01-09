class UsersController < ApplicationController
  def login
    # @leaders = LeadersFacade.leaderboard
  end

  def show
  end

  def update
    serialized_location = UserSerializer.serialize_user(params[:city], params[:state])
    BEService.update_user(session[:user_id], serialized_location)
    redirect_to '/dashboard'
  end

  def logout
    reset_session
    redirect_to '/'
  end
end