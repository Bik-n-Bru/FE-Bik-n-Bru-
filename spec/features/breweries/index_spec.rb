require "rails_helper"

RSpec.describe "Breweries Index Page" do

  describe "nav bar" do
    before(:each) do
      VCR.use_cassette('bend_breweries_redux_with_activites') do
        page.set_rack_session(user_id: '1')
        visit "/breweries" 
      end
    end
  
    it "should have as navigation bar that includes a link to the user Dashboard, a link to Home, and a link to Log Out" do
      within("#nav_bar") do
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("Home")
        expect(page).to have_link("Logout")
      end 
    end
  end
  
  describe "if the user city and state are valid/breweries can be found" do
    before(:each) do
      VCR.use_cassette('bend_breweries_redux_with_activites') do
        page.set_rack_session(user_id: '1')
        visit "/breweries" 
      end
    end

    it "shows a list of breweries and includes the brewery name (which is a link to that breweries website), address, phone number, 
      and brewery type" do
    
      within("#brewery_10-barrel-brewing-co-bend-1") do
        expect(page).to have_link("10 Barrel Brewing Co")
        expect(page).to have_content("Brewery Type: brewery")
        expect(page).to have_content("62970 18th St, Bend, Oregon, 97701-9847")
        expect(page).to have_content("541-585-1007")
      end
      
      within("#brewery_bend-brewing-co-bend") do
        expect(page).to have_link("Bend Brewing Co")
        expect(page).to have_content("Brewery Type: brewery")
        expect(page).to have_content("1019 NW Brooks St, Bend, Oregon, 97703-2018")
        expect(page).to have_content("541-383-1599")
      end
    end

    it "if there is no link to the brewery website, the brewery name will only be text, not a link" do
      within("#brewery_10-barrel-brewing-co-bend-pub-bend") do
        expect(page).to have_content("10 Barrel Brewing Co - Bend Pub")
        expect(page).to_not have_link("10 Barrel Brewing Co - Bend Pub")
      end
    end
  end

  describe "if city or state is nil" do
    before(:each) do
      @user_data = {data: {id: "12", type: "user", attributes: {username: "SPrefontaine", token: "12345abcde", athlete_id: "12345", city: nil, state: nil}, relationships:{activities:{data:[]},badges:{data:[]}}}}
      stub_request(:any, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/12').to_return(body: @user_data.to_json)
      page.set_rack_session(user_id: '12')
      visit "/breweries" 
    end

    it "shows a message that says there is not a city/state saved, please update, and has a form to do so" do
      expect(page).to have_content("We do not have a city/state saved for you, please update")
      within("#update_form") do
        expect(page).to have_field(:city)
        expect(page).to have_select(:state)
        expect(page).to have_button("Submit")
      end 
    end
  end

  describe "if no breweries are found (ex. City/State are not valid or there are no breweries in the area)" do
    before(:each) do
        # @user_data = {data: {id: "12", type: "user", attributes: {username: "SPrefontaine", token: "12345abcde", athlete_id: "12345", city: "not a city", state: "not a state"}, relationships:{activities:{data:[]},badges:{data:[]}}}}
      page.set_rack_session(user_id: '12')
    end

    it "shows a message that no breweries were found, please update city/state and has a form to do so" do
      VCR.use_cassette('update_user_city_state') do
        serialized_data = {
                            data: {
                                city: "not a city",
                                state: "not a state"
                            }
                          }
        BEService.update_user(12, serialized_data)
      end

      VCR.use_cassette('no_breweries_found') do
        visit "/breweries"

        expect(page).to have_content("We were unable to find any breweries for you, please add a new city/state")
        within("#update_form") do
          expect(page).to have_field(:city)
          expect(page).to have_select(:state)
          expect(page).to have_button("Submit")
        end
      end
    end

    it "when the city and state are filled out and the submit button is clicked, and breweries are found, when
      user returns to the breweries index page where a list of breweries are seen" do
        VCR.use_cassette('change_city_state_to_bend_oregon') do
          visit "/breweries"
      
          fill_in :city, with: "Bend"
          select("Oregon", from: :state)
          click_button("Submit")
        end
        
        VCR.use_cassette('bend_breweries_for_user_12') do
          visit "/breweries"

          within("#brewery_10-barrel-brewing-co-bend-1") do
            expect(page).to have_link("10 Barrel Brewing Co")
            expect(page).to have_content("Brewery Type: brewery")
            expect(page).to have_content("62970 18th St, Bend, Oregon, 97701-9847")
            expect(page).to have_content("541-585-1007")
          end 
        end 
      end
    end 
  end

#describe when a phone number is nil
#describe when a brewery does not have a website

#will need to mock up a fake user who does not have any city listed or any state listed
  #currently with "not a city" or "not a state" user just gets back and empty array
  #of breweries

  # describe "if the user DOES NOT have city and state attributes saved" do
  #   it "shows a message notifying the user that they have not filled in a city or state" do
  #     page.set_rack_session(user_id: '5')

  #     visit "/breweries"

  #     expect(page).to have_content("We do not have a city/state saved for you, please update")
  #   end

  #   it "has a form for the user to fill in their city and state, which are saved as attributes" do
  #     page.set_rack_session(user_id: '4')
  #     visit "/breweries"

  #     within("#update_form") do
  #       expect(page).to have_field("City")
  #       expect(page).to select_tag("State")
  #       click_button("Submit")
  #     end 

  #     expect(page).to_not have_content()
  #   end
  # end 
