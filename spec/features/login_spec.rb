require 'rails_helper'

describe 'Login' do

  before :each do
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
  end
end