require "rails_helper"

RSpec.describe "Breweries Index Page" do

  describe "nav bar" do
    it "should have as navigation bar that includes a link to the 
      user Dashboard, a link to Home, and a link to Log Out" do
        visit "/breweries" 

        expect(page).to have_link("Dashboard")
        expect(page).to have_link("Home")
        expect(page).to have_link("Logout")
    end
  end
  
  describe "if the user city and state attributes saved" do
    it "shows a list of breweries and includes the brewery name (which is a link to that
      breweries website), address, phone number, and brewery type" do
        @user_input = {
                        data: {
                          id: '1',
                          attributes: {
                            athlete_id: '27272687',
                            username: 'StevePrefontaine',
                            token: '6b16d87c382z7b979965dbc28b9qbfc47197c2d9',
                            city: 'Bend',
                            state: 'Oregon'
                            }
                          }
                      }
      @user = User.new(@user_input)
      #Need session data to write this test (Rich has )

      visit "/breweries"
binding.pry
      within("#brewery_10-barrel-brewing-co-bend-1") do
        expect(page).to have_link("10 Barrel Brewing Co")
        expect(page).to have_content("62970 18th St, Bend, Oregon, 97701-9847")
        expect(page).to have_content("541-585-1007")
        expect(page).to have_content("Brewery1 Number")
      end

      within("#brewery_10-barrel-brewing-co-bend-2") do
        expect(page).to have_link("Brewery2 Name")
        expect(page).to have_content("Brewery2 Address")
        expect(page).to have_content("Brewery2 Phone Number")
        expect(page).to have_content("Brewery2 Number")
      end
    end
    "id": "10-barrel-brewing-co-bend-1",
        "name": "10 Barrel Brewing Co",
        "brewery_type": "large",
        "street": "62970 18th St",
        "address_2": null,
        "address_3": null,
        "city": "Bend",
        "state": "Oregon",
        "county_province": null,
        "postal_code": "97701-9847",
        "country": "United States",
        "longitude": "-121.28170597038259",
        "latitude": "44.08683530625218",
        "phone": "5415851007",
        "website_url": "http://www.10barrel.com",
        "updated_at": "2023-01-04T04:46:02.393Z",
        "created_at": "2023-01-04T04:46:02.393Z"
    },

    "id": "10-barrel-brewing-co-bend-2",
        "name": "10 Barrel Brewing Co",
        "brewery_type": "large",
        "street": "1135 NW Galveston Ave Ste B",
        "address_2": null,
        "address_3": null,
        "city": "Bend",
        "state": "Oregon",
        "county_province": null,
        "postal_code": "97703-2465",
        "country": "United States",
        "longitude": "-121.32880209261799",
        "latitude": "44.057564901366796",
        "phone": "5415851007",
        "website_url": null,
        "updated_at": "2023-01-04T04:46:02.393Z",
        "created_at": "2023-01-04T04:46:02.393Z"
  end

  describe "if the user DOES NOT have city and state attributes saved" do
    it "shows a message notifying the user that they have not filled in a city or state" do
      visit "/breweries"

      expect(page).to have_content("We do not have a city/state saved for you, please update")
    end

    it "has a form for the user to fill in their city and state, which are saved as attributes" do
      visit "/breweries"

      within("#update_form") do
        expect(page).to have_field("City")
        expect(page).to have_field("State")
        click_button("Submit")
      end 
      
      expect(@user.city).to eq("Bend")
      expect(@user.city).to eq("Oregon")
    end
end