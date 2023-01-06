class LeadersFacade
  def self.leaderboard(parsed_json)
    parsed_json[:data].map do |leader|
      Leader.new(leader)
    end
  end

end