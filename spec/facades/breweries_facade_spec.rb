require 'rails_helper'

RSpec.describe BreweryFacade do
  describe 'class methods' do
    describe '#user_location_breweries' do
      it 'returns and array of Brewery objects' do
        user_id = "1"
        breweries = BreweryFacade.user_location_breweries(user_id)

        expect(breweries).to be_an_instance_of(Array)
        expect(breweries.count).to eq(24)
        expect(breweries[0].id).to eq("10-barrel-brewing-co-bend-1")
        expect(breweries[0].name).to eq("10 Barrel Brewing Co")
        expect(breweries[0].street_address).to eq("62970 18th St")
        expect(breweries[0].city).to eq("Bend")
        expect(breweries[0].state).to eq("Oregon")
        expect(breweries[0].zip_code).to eq("97701-9847")
        expect(breweries[0].phone_number).to eq("5415851007")
        expect(breweries[1].id).to eq("10-barrel-brewing-co-bend-2")

        expect(breweries.count).to_not eq(50)
        expect(breweries[2].id).to_not eq("10-barrel-brewing-co-bend-1")
      end
    end 
  end
end