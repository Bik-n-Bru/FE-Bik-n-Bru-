class LeadersFacade
  def self.leaderboard
    leaders_json = BEService.leaderboard[:data].map do |leader|
      Leader.new(leader)
    end
  end
end