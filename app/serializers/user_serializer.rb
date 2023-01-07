class UserSerializer
  def self.serialize_user(city, state)
    {
    data: {
        city: city,
        state: state
      }
    }
  end
end