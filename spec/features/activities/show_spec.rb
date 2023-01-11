require "rails_helper"

RSpec.describe "Activity Show Page" do

  before(:each) do
    @user_data = {data: {id: "1", type: "user", attributes: {username: "SPrefontaine", token: "12345abcde", athlete_id: "12345", city: "Eugene", state: "Oregon"}, relationships:{activities:{data:[]},badges:{data:[]}}}}

    @activity1_data = {data: {id:'1', attributes:{brewery_name:'Wagon Wheel', distance: 3.7, calories: 400, num_drinks: 2, drink_type: 'IPA', dollars_saved: 1.97, lbs_carbon_saved: 1.2, user_id: 1, created_at: "2023-01-09 18:10:07"}}}
    @activity2_data = {data: {id:'1', attributes:{brewery_name:'Wild Corgi Pub', distance: 5.1, calories: 521, num_drinks: 3, drink_type: 'Domestic', dollars_saved: 2.71, lbs_carbon_saved: 1.6, user_id: 2, created_at: "2022-03-04 18:10:07"}}}


    stub_request(:any, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/1').to_return(body: @user_data.to_json)
    stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/activities/1').to_return(body: @activity1_data.to_json)
      
    page.set_rack_session(user_id: "1")
    @activity = ActivitiesFacade.find_an_activity("1")
  end

  describe "nav bar" do
    it "should have as navigation bar that includes a link to the user Dashboard, a link to Home, and a link to Log Out" do
      visit "/activities/1"

      within("#nav_bar") do
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("Home")
        expect(page).to have_link("Logout")
      end 
    end
  end
  
  describe "if the user visits the show page of an activity that belongs to that user" do
    it "shows the brewery name and date that the activity was done as the header" do
      visit "/activities/1"

      within("#header") do
        expect(page).to have_content(@activity.brewery_name)
        expect(page).to have_content(@activity.created_at)
      end 
    end
    
    it "shows the brewery beverage of choice, total calories burned, number of drinks earned, the gas 
      money that the user saved, and carbon footprint saved" do
      visit "/activities/1"

      within("#activity_info") do
        expect(page).to have_content("Calories Burned: #{@activity.calories}")
        expect(page).to have_content("Distance Traveled: #{@activity.distance} miles")
        expect(page).to have_content("Gas Money Saved: $#{@activity.dollars_saved}")
        expect(page).to have_content("Drink Type: #{@activity.drink_type}")
        expect(page).to have_content("Number of #{@activity.drink_type}'s Earned: #{@activity.num_drinks}")
        expect(page).to have_content("Carbon Footprint Offset: #{@activity.lbs_carbon_saved}")
      end
    end 
  end 

  describe "if the user visits the show page of an activity that does not belong to that user" do
    it "has a message that the user does not have access to that activity" do
      @activity2_data = {data: {id:'2', attributes:{brewery_name:'Wild Corgi Pub', distance: 5.1, calories: 521, num_drinks: 3, drink_type: 'Domestic', dollars_saved: 2.71, lbs_carbon_saved: 1.6, user_id: 2, created_at: "2022-03-04 18:10:07"}}}
      stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/activities/2').to_return(body: @activity2_data.to_json)
      @activity = ActivitiesFacade.find_an_activity("2")
      visit "/activities/2"
      expect(page).to have_content("Activity Show Page")
      expect(page).to have_content("You do not have access to this activity")
    end
  end
end