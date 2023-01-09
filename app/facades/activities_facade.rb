class ActivitiesFacade
  def self.user_activities(user_id)
    activities = BEService.user_activities(user_id)

    activities[:data].map do |activity_data|
      Activity.new(activity_data)
    end
  end
end