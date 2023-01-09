class ActivityFacade

  xdef find_all_activities(user_id)
    results = BEService.user_activities(user_id)
    results[:data].map do |activity|
      Brewery.new(activity)
  end

  def self.create_an_activity(activity_params)

  end
  
  def self.find_activity(activity_id)
  end
  
  # def self.find_last_activity(user_id)
  #   #do i need this? Or can I call all activities and choose the most recent one?
  # end
end