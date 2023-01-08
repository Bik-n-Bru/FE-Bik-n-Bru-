require 'rails_helper'

RSpec.describe 'The Dashboard Show Page', type: :feature do
  describe 'As a logged in user' do

    before :each do
      @user_data = {data: {id: "1", type: "user", attributes: {username: "SPrefontaine", token: "12345abcde", athlete_id: "12345", city: "Eugene", state: "Oregon"}, relationships:{activities:{data:[]},badges:{data:[]}}}}
      @user_badges = {data: ['Visited 10 breweries', 'Completed 1 Activity', 'Cycled 100 miles']}
      stub_request(:any, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/99').to_return(body: @user_data.to_json)
      stub_request(:any, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/99/badges').to_return(body: @user_badges.to_json)
      page.set_rack_session(user_id: '99')
      visit '/dashboard'
    end

    it 'I see my possesive name followed by dashboard' do
      expect(page).to have_content("#{@user_data[:data][:attributes][:username]}'s Dashboard")
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

    describe 'Badges Section' do
      it 'I see a section with the badges I have earned' do
        within("#badges") do
          expect(page).to have_css("img[src*='/assets/badges/Visited 10 breweries-8b6e560c05d64d4d83bc961d866c8cb78e326a26ae4d1527e4070e7c060f4552.jpg']")
          expect(page).to have_css("img[src*='/assets/badges/Completed 1 Activity-abac81fa505a42de52eac06cbcb00c56fc4b1f70b5d419680bf5e61f4872376d.jpg']")
          expect(page).to have_css("img[src*='/assets/badges/Cycled 100 miles-e597dbbfcc87c1ea9d50ae07fb210ed55f24eb1a9fe91491c69ed481fccb7d45.jpg']")
          expect(page).to have_no_css("img[src*='/assets/badges/Cycled 500 miles-f365b81676358c173fbc4157e7d4d5649247e2808b5de4fbb1b7ba74432fff14.jpg']")
        end
      end
    end

    xit 'I see a form to submit an activity. When I fill out this form I am
    redirected to the Activity Show Page' do
      within("#new_activity") do

      end
    end

    xit 'I see a section with my 10 most recent activities' do
      within("#recent_activities") do
        
      end
    end
  end

  describe 'As a logged in user without a city or state provided' do
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

    end
  end
  describe 'As a logged in user with a city and state provided' do
    before :each do
      page.set_rack_session(user_id: '9')
      visit '/dashboard'
    end

    xit 'displays a side panel with 10 breweries in the users area if location
    data has been provided' do
      within("#breweries") do
        
      end
    end
  end


  # it 'displays a link to view more breweries, which redirectes to brewery index page'
end