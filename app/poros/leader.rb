class Leader
  attr_reader :username,
              :miles,
              :beers,
              :co2_saved
              
  def initialize(leader_data)
    @username = leader_data[:attributes][:username]
    @miles = leader_data[:attributes][:miles]
    @beers = leader_data[:attributes][:beers]
    @co2_saved = leader_data[:attributes][:co2_saved]
  end
end