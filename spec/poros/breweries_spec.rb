require "rails_helper"

RSpec.describe "Brewery Poros" do

  it "exists and has attributes" do
    attributes = {id: 1, attributes: {name: "Deschutes Brewery", address: "1222 NE 11th St, Bend, Or 97701", phone_number_: "123-456-7890" , website: "https://www.deschutesbrewery.com/", type: "micro" }}
    
    brewery = Brewery.new(attributes)

    expect(brewery).to be_an_instance_of(Brewery)
    expect(brewery.id).to eq(1)
    expect(brewery.name).to eq("Deschutes Brewery")
    expect(brewery.address).to eq("1222 NE 11th St, Bend, Or 97701")
    expect(brewery.phone_number).to eq("123-456-7890")
    expect(brewery.website).to eq("https://www.deschutesbrewery.com/")
    expect(brewery.type).to eq("micro")
  end
end

