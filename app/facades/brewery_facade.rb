class BreweryFacade

  def self.user_location_breweries(user_id)
    data = BEService.breweries_by_user_location[:data]
    data.map { |brewery| Brewery.new(brewery) }
  end
end