class ActivitiesFacade
  def self.user_activities(user_id)
    activities = BEService.user_activities(user_id)

    activities[:data].map do |activity_data|
      Activity.new(activity_data)
    end
  end

  def self.find_an_activity(activity_id)
    activity = BEService.find_activity(activity_id)
    Activity.new(activity[:data])
  end
end