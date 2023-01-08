require "rails_helper"

RSpec.describe "Breweries Index Page" do

  before(:each) do
    page.set_rack_session(user_id: '1')
  end

  describe "nav bar" do
    it "should have as navigation bar that includes a link to the user Dashboard, a link to Home, and a link to Log Out" do
      visit "/breweries" 

      within("#nav_bar") do
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("Home")
        expect(page).to have_link("Logout")
      end 
    end
  end
  
  describe "if the user city and state attributes saved" do
    it "shows a list of breweries and includes the brewery name (which is a link to that breweries website), address, phone number, 
      and brewery type" do
      visit "/breweries"

      
      within("#brewery_10-barrel-brewing-co-bend-1") do
      expect(page).to have_link("10 Barrel Brewing Co")
      expect(page).to have_content("Brewery Type: brewery")
        expect(page).to have_content("62970 18th St, Bend, Oregon, 97701-9847")
        expect(page).to have_content("541-585-1007")
      end
save_and_open_page
      within("#brewery_bend-brewing-co-bend") do
        expect(page).to have_link("Bend Brewing Co")
        expect(page).to have_content("Brewery Type: brewery")
        expect(page).to have_content("1019 NW Brooks St, Bend, Oregon, 97703-2018")
        expect(page).to have_content("541-383-1599")
      end
    end
  end
end 

  # describe "if the user DOES NOT have city and state attributes saved" do
  #   it "shows a message notifying the user that they have not filled in a city or state" do
  #     visit "/breweries"

  #     expect(page).to have_content("We do not have a city/state saved for you, please update")
  #   end

  #   it "has a form for the user to fill in their city and state, which are saved as attributes" do
  #     visit "/breweries"

  #     within("#update_form") do
  #       expect(page).to have_field("City")
  #       expect(page).to have_field("State")
  #       click_button("Submit")
  #     end 
      
  #     expect(@user.city).to eq("Bend")
  #     expect(@user.city).to eq("Oregon")
  #   end
  # end 

  #describe when a phone number is nil
  #describe when a brewery does not have a website