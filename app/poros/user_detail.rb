class UserDetail
  attr_reader :id,
              :username,
              :athlete_id,
              :city,
              :state,
              :activities
              
  def initialize(user_data)
    @id = user_data[:data][:id]
    @username = user_data[:data][:attributes][:username]
    @athlete_id = user_data[:data][:attributes][:athlete_id]
    @city = user_data[:data][:attributes][:city]
    @state = user_data[:data][:attributes][:state]
    @activities = user_data[:data][:relationships][:activities][:data]
  end
end