class UsersController < ApplicationController
  def login
    @leaders = LeadersFacade.leaderboard
  end
end