class UserSerializer
  def self.serialize_user(city, state)
    {
    user: {
      data: {
          city: city,
          state: state
        }
      }
    }
  end
end