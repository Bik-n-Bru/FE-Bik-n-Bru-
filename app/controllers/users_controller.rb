class UsersController < ApplicationController
  def login
    # @leaders = LeadersFacade.leaderboard
  end

  def show
    
  end

  def logout
    reset_session
    redirect_to '/'
  end

  def update
    @user = User.find[:]
    # @user update stuff (the update process, the city and state has to get sent to the back end service)
    # then call on user and check city and state
    redirect_to "/breweries"
  end
end