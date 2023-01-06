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

    end
  end

  describe "if the user DOES NOT have city and state attributes saved" do
    it "shows a message notifying the user that they have not filled in a city or state" do

    end

    it "has a form for the user to fill in their city and state, which are saved as attributes" do

    end

    it "has an update button" do
      within("#update_form") do
        expect(page).to have_button("Update")
      end
    end
  end

end