class UsersController < ApplicationController
  def login
    @leaders = LeadersFacade.leaderboard
  end

  def show
    
  end

  def logout
    reset_session
    redirect_to '/'
  end
end