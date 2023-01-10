class BadgesFacade
  def self.user_badges(user_id)
    badges_json = BEService.find_user_badges(user_id)
    badges_json[:data].map do |badge_data|
      Badge.new(badge_data)
    end
  end
end