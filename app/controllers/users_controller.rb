class UsersController < ApplicationController
  def login
    
  end

  def show
    
  end

  def logout
    reset_session
    redirect_to '/'
  end
end