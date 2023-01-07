require "rails_helper"

RSpec.describe "Brewery Poros" do

  xdescribe "attributes" do
    it "exists and has attributes" do
      attributes = {id: "1", attributes: {name: "Deschutes Brewery", address: "1222 NE 11th St, Bend, Or 97701", phone_number_: "123-456-7890" , website: "https://www.deschutesbrewery.com/", type: "micro" }}
      
      brewery = Brewery.new(attributes)

      expect(brewery).to be_an_instance_of(Brewery)
      expect(brewery.id).to eq("1")
      expect(brewery.name).to eq("Deschutes Brewery")
      expect(brewery.address).to eq("1222 NE 11th St, Bend, Or 97701")
      expect(brewery.phone_number).to eq("123-456-7890")
      expect(brewery.website).to eq("https://www.deschutesbrewery.com/")
      expect(brewery.type).to eq("micro")
    end
  end 

  describe "class methods" do
    it "#phone_number_conversion" do
      attributes = {id: "10-barrel-brewing-co-denver-denver", name: "10 Barrel Brewing Co - Denver", street: "2620 Walnut St", city: "Denver", state: "Colorado", postal_code: "80205-2231", phone: "7205738992" , website_url: "https://www.deschutesbrewery.com/", brewery_type: "large" }
      brewery = Brewery.new(attributes)
      binding.pry
      expect(brewery.phone_number.phone_number_conversion(phone_number)).to eq("123-456-7890")
      # expect(phone_number_2.phone_number_conversion(phone_number_1)).to eq("223-334-4456")
    end
  end


end

