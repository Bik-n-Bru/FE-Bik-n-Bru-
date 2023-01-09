class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @user ||= UsersFacade.user_detail(session[:user_id]) if session[:user_id]
  end
end
