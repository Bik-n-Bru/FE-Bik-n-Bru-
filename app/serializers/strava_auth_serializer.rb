class StravaAuthSerializer
  def self.serialize(user_data)
    {
      data: {
        username: user_data[:athlete][:username],
        token: user_data[:access_token],
        athlete_id: user_data[:athlete][:id],
        city: user_data[:athlete][:city],
        state: user_data[:athlete][:state]
      }
    }
  end
end