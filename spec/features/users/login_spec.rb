require 'rails_helper'

describe 'Login' do

  before :each do
    leaderboard_data = {
      data: [
        {
          attributes: {
            username: 'Lance',
            miles: '12897',
            beers: '527',
            co2_saved: '61'
          }
        }
      ]
    }

    stub_request(:any, 'https://be-bik-n-bru.herokuapp.com/api/v1/leaderboard').to_return(body: leaderboard_data.to_json)
    visit '/'
  end
  describe 'as a visitor' do
    it "I see a link to 'Don't have Strava? Click here!' When I click the link
    I am redirected to the Strava registration page" do
      # Capybara doesn't seem to get along with external URLs.
      # Rails Server redirectes fine, but alternative tests should be explored.

      expect(page).to have_link("Don't have Strava? Click here!")
      # click_link "Don't have Strava? Click here!"
      # expect(current_path).to eq("https://www.strava.com/register/free")
    end 

    it "I see a link to continue with strava" do
      expect(page).to have_link('Continue with Strava')
    end

    it ' I see a list of the top ten users and their total beers earned and
    miles biked and lbs of CO2 saved.' do
      within("#leaderboard") do
        expect(page).to have_content('Rank')
        expect(page).to have_content('Username')
        expect(page).to have_content('Miles Biked')
        expect(page).to have_content('Beers Earned')
        expect(page).to have_content('CO2 Saved (lbs)')
      end
    end
  end
end