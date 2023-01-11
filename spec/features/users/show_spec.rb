require 'rails_helper'

RSpec.describe 'The Dashboard Show Page', type: :feature do
  describe 'As a logged in user' do

    before :each do
      @user_data = {data: {id: "1", type: "user", attributes: {username: "SPrefontaine", token: "12345abcde", athlete_id: "12345", city: "Eugene", state: "Oregon"}, relationships:{activities:{data:[]},badges:{data:[]}}}}
      @user_badges = {data: [{id: "1",type: "badge",attributes: {title: "Completed 1 Activity"},relationships: {user: {data: {id: "1",type: "user"}}}},
            {id: "2",type: "badge",attributes: {title: "Cycled 100 miles"}, relationships: {user: {data: {id: "1",type: "user"}}}}]}
      @brewery_data = {:data=>
      [{:id=>"agrarian-ales-llc-eugene",
        :type=>"brewery",
        :attributes=>{:name=>"Agrarian Ales, LLC", :street_address=>"31115 W Crossroads Ln", :city=>"Eugene", :state=>"Oregon", :zipcode=>"97408-9220", :phone=>"5416323803", :website_url=>"http://www.agales.com"}},
       {:id=>"alesong-brewing-and-blending-eugene",
        :type=>"brewery",
        :attributes=>{:name=>"Alesong Brewing and Blending", :street_address=>"1000 Conger St Ste C", :city=>"Eugene", :state=>"Oregon", :zipcode=>"97402-2950", :phone=>"5419723303", :website_url=>"http://www.alesongbrewing.com"}}]}
      
      @activities_data = {data:[{id:'1', attributes:{brewery_name:'Wagon Wheel', distance: 3.7, calories: 400, num_drinks: 2, drink_type: 'IPA', dollars_saved: 1.97, lbs_carbon_saved: 1.2, user_id: 99, created_at: "2023-01-10 04:24:35"}},
        {id:'2', attributes:{brewery_name:'Wild Corgi Pub', distance: 5.1, calories: 521, num_drinks: 3, drink_type: 'Domestic', dollars_saved: 2.71, lbs_carbon_saved: 1.6, user_id: 99, created_at: "2023-01-10 04:24:35"}}]}

      new_activity_data = {data: {id:'3', attributes:{brewery_name:'Wagon Wheel', distance: 3.7, calories: 400, num_drinks: 2, drink_type: 'IPA', dollars_saved: 1.97, lbs_carbon_saved: 1.2, user_id: 5, created_at: "2023-01-10 04:24:35"}}}
      stub_request(:get, "https://be-bik-n-bru.herokuapp.com/api/v1/activities/3").to_return(body: new_activity_data.to_json)
      stub_request(:post, "https://be-bik-n-bru.herokuapp.com/api/v1/activities").to_return(body: new_activity_data.to_json)
      stub_request(:any, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/99').to_return(body: @user_data.to_json)
      stub_request(:any, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/99/badges').to_return(body: @user_badges.to_json)
      stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/breweries/99').to_return(body: @brewery_data.to_json)
      stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/99/activities').to_return(body: @activities_data.to_json)
      stub_request(:post, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/99/activities').to_return(body: @activities_data.to_json)
      @oregon_gas = {data: {state: "oregon",gas_price: "3.270"}}
  
      stub_request(:get, "https://be-bik-n-bru.herokuapp.com/api/v1/gas_price/1").to_return(body: @oregon_gas.to_json)
      page.set_rack_session(user_id: '99')
      visit '/dashboard'
    end

    it 'I see my possesive name followed by dashboard' do
      expect(page).to have_content("#{@user_data[:data][:attributes][:username]}'s Dashboard")
    end

    it "shows gas price on dashboard" do
      within("#the_gas_price") do
        expect(page).to have_content("The current price of gas per gallon is $3.27")
      end
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
          expect(page).to have_css("img[src*='/assets/badges/Completed 1 Activity-abac81fa505a42de52eac06cbcb00c56fc4b1f70b5d419680bf5e61f4872376d.jpg']")
          expect(page).to have_css("img[src*='/assets/badges/Cycled 100 miles-e597dbbfcc87c1ea9d50ae07fb210ed55f24eb1a9fe91491c69ed481fccb7d45.jpg']")
          expect(page).to have_no_css("img[src*='/assets/badges/Visited 10 breweries-8b6e560c05d64d4d83bc961d866c8cb78e326a26ae4d1527e4070e7c060f4552.jpg']")
          expect(page).to have_no_css("img[src*='/assets/badges/Cycled 500 miles-f365b81676358c173fbc4157e7d4d5649247e2808b5de4fbb1b7ba74432fff14.jpg']")
        end
      end
    end

    describe 'New Activity Section' do
      it 'I see a form to submit an activity. When I fill out this form I am
      redirected to the Activity Show Page' do
        within("#new_activity") do
          expect(page).to have_content('Did you make it to a brewery?')
          select('Agrarian Ales, LLC', from: 'brewery_name')
          select('IPA', from: 'drink_type')
          click_button ("Tell me how many beers I've earned!")
          expect(current_path).to eq('/activities/3')
        end
      end
    end


    it 'I see a section with my 10 most recent activities' do
      within("#recent_activities") do
        expect(page).to have_link("#{@activities_data[:data][0][:attributes][:brewery_name]}")
        expect(page).to have_link("#{@activities_data[:data][1][:attributes][:brewery_name]}")
      end
    end
  end

  describe 'As a logged in user without a city or state provided' do
    describe 'when I visit "/dashboard"' do
      before :each do
        VCR.use_cassette('user_5_empty_info') do
        page.set_rack_session(user_id: '5')
        visit '/dashboard'
        end
      end
      
      it 'displays a form to add city and state if it has not been provided.
      When I fill in this form I am redirected to my dashboard where I no
      longer see a form to update my address' do
        VCR.use_cassette('user_5_in_fill') do
          expect(page).to have_selector('#address_form')
          expect(page).to_not have_content("The current price of gas per gallon is $3.27")
          within("#address_form") do
            fill_in "city", with: "Eugene"
            fill_in "state", with: "Oregon"
            click_button 'Submit'
          end

        expect(current_path).to eq('/dashboard')
        expect(page).to have_no_selector('#address_form')
        end  
      end
    end
  end

  describe 'As a logged in user with a city and state provided' do
    before :each do
      VCR.use_cassette('bend_breweries_with_activites') do
        page.set_rack_session(user_id: '1')
        visit '/dashboard'

      end
    end

    it 'displays a side panel with 10 breweries in the users area and a link
    to the breweries index' do

      within("#breweries") do
        expect(page).to have_link("Agrarian Ales, LLC")
        expect(page).to have_link("Alesong Brewing and Blending")
        expect(page).to have_link('View All Local Breweries')
        click_link 'View All Local Breweries'
      end
      expect(current_path).to eq('/breweries')
    end
  end
end