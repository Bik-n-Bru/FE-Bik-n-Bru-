class User
  attr_reader :id,
              :athlete_id,
              :username,
              :token,
              :city,
              :state
  def initialize(user_data)
    @id = user_data[:data][:id]
    @athlete_id = user_data[:data][:attributes][:athlete_id]
    @username = user_data[:data][:attributes][:username]
    @token = user_data[:data][:attributes][:token]
  end
end