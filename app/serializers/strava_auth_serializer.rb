class StravaAuthSerializer
  def self.serialize(user_data)
    {
      data: {
        username: "#{user_data[:athlete][:firstname]} #{user_data[:athlete][:lastname]}",
        token: user_data[:access_token],
        athlete_id: user_data[:athlete][:id],
      }
    }
  end
end