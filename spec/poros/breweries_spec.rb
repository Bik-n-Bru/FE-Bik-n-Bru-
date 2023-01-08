require "rails_helper"

RSpec.describe "Brewery Poros" do

  describe "attributes" do
    it "exists and has attributes" do
      attributes = {id: "10-barrel-brewing-co-bend-1", type: "micro", attributes: {name: "10 Barrel Brewing Co", street_address: "62970 18th St", city: "Bend", state: "Oregon", zipcode: "97701-9847", phone: "5415851007" , website_url: "https://www.deschutesbrewery.com/" }}
      
      brewery = Brewery.new(attributes)

      expect(brewery).to be_an_instance_of(Brewery)
      expect(brewery.id).to eq("10-barrel-brewing-co-bend-1")
      expect(brewery.name).to eq("10 Barrel Brewing Co")
      expect(brewery.street_address).to eq("62970 18th St")
      expect(brewery.city).to eq("Bend")
      expect(brewery.state).to eq("Oregon")
      expect(brewery.zip_code).to eq("97701-9847")
      expect(brewery.phone_number).to eq("5415851007")
      expect(brewery.website).to eq("https://www.deschutesbrewery.com/")
      expect(brewery.type).to eq("micro")
    end
  end 
end

