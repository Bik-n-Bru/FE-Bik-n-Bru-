require 'rails_helper'

RSpec.describe 'The Dashboard Show Page', type: :feature do
  context 'As a logged in user without a city or state provided' do
    describe 'when I visit "/dashboard"' do
      before :each do
        page.set_rack_session(user_id: '1')
        visit '/dashboard'
      end
      
      it 'displays a form to add city and state if it has not been provided.
      When I fill in this form I am redirected to my dashboard where I no
      longer see a form to update my address' do
        expect(page).to have_selector('#address_form')

        within("#address_form") do
          fill_in "city", with: "Eugene"
          fill_in "state", with: "Oregon"
          click_button 'Submit'
        end

        expect(current_path).to eq('/dashboard')
        expect(page).to have_no_selector('#address_form')

        reset = {data:{city: "", state: ""}}
        BEService.update_user('1', reset)
      end

      it 'displays a link to logout, home, and dashboard' do
        expect(page).to have_link('Logout')
        expect(page).to have_link('Home')
        expect(page).to have_link('Dashboard')
      end

      it 'when I click the link to logout, I am redirected to the login page
      and the session is reset' do
        click_link 'Logout'
        expect(current_path).to eq('/')
        expect {page.get_rack_session_key('user_id')}.to raise_error(KeyError)
      end

    end
  end
  # it 'displays a side panel with 10 breweries in the users area if location
  # data has been provided'


  # it 'displays a link to view more breweries, which redirectes to brewery index page'
end