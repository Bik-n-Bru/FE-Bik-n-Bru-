class UsersFacade
  def self.user_detail(user_id)

    user_json = BEService.find_user(user_id)
    badges = BadgesFacade.user_badges(user_id)
    breweries = BreweryFacade.user_location_breweries(user_id).first(10)
    activities = ActivitiesFacade.user_activities(user_id)
    UserDetail.new(user_json, badges, breweries, activities)
  end
end