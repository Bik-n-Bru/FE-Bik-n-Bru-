class BreweryFacade

  def self.user_location_breweries(user_id)
    results = BEService.breweries_by_user_location(user_id)
    results[:data].map do |brewery|
      Brewery.new(brewery)
    end 
  end 
end