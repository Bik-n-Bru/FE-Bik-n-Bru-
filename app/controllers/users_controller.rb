class UsersController < ApplicationController
  def login
    @leaders = LeadersFacade.leaderboard
  end

  def show
    if @user.state != ""
      state_price = GasFacade.price(@user.state)
      @price = state_price.gas_price    
    end
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

# it "shows gas price on dashboard" do
#   # within("#the_gas_price") do
#   #   expect(page).to have_content("The current price of gas per gallon is $3.27")
#   # end
# end

# @oregon_gas = {data:{gas_price: "3.270"}}
  
#       stub_request(:get, "https://be-bik-n-bru.herokuapp.com/api/v1/get_gas_price/Oregon").to_return(body: @oregon_gas.to_json)