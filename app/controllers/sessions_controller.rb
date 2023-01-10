class SessionsController < ApplicationController
  def create
    user_data = StravaService.authorize_user_account(params[:code])
    if params[:error] == 'access_denied'
      redirect_to '/'
    else
      serialized_user_data = StravaAuthSerializer.serialize(user_data)
      user_parsed_json = BEService.login_user(serialized_user_data)

      @user = User.new(user_parsed_json)
      session[:user_id] = @user.id
      redirect_to '/dashboard'
    end
  end
end