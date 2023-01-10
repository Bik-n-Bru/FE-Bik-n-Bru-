class ActivitySerializer
  def self.serialize_activity(brewery_name, drink_type, user_id)
    {
      data: {
        brewery_name: brewery_name,
        drink_type: drink_type,
        user_id: user_id
      }
    }
  end
end