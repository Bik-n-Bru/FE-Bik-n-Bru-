require 'rails_helper'

RSpec.describe ActivitiesFacade do
  describe 'class methods' do
    describe '#user_activities' do
      it 'returns an array of Activity objects' do
        activities_data = {data:[{id:'1', attributes:{brewery_name:'Wagon Wheel', distance: 3.7, calories: 400, num_drinks: 2, drink_type: 'IPA', dollars_saved: 1.97, lbs_carbon_saved: 1.2, user_id: 5}},
        {id:'1', attributes:{brewery_name:'Wild Corgi Pub', distance: 5.1, calories: 521, num_drinks: 3, drink_type: 'Domestic', dollars_saved: 2.71, lbs_carbon_saved: 1.6, user_id: 5}}]}

        stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/1/activities').to_return(body: activities_data.to_json)

        activities = ActivitiesFacade.user_activities('5')

        activities.each do |activity|
          expect(activity).to be_a Activity
        end
      end
    end

    describe "#find_an_activity" do
      it "returns an Activity object that matches the search criteria" do
        activities_data = {data: {id:'1', attributes:{brewery_name:'Wagon Wheel', distance: 3.7, calories: 400, num_drinks: 2, drink_type: 'IPA', dollars_saved: 1.97, lbs_carbon_saved: 1.2, user_id: 5, created_at: "2023-01-09 18:10:07"}}}

        stub_request(:get, "https://be-bik-n-bru.herokuapp.com/api/v1/activities/1").to_return(body: activities_data.to_json)
        
        activity = ActivitiesFacade.find_an_activity("1")
        
        expect(activity).to be_an(Activity)
        expect(activity.id).to eq("1")
        expect(activity.brewery_name).to eq("Wagon Wheel")
        expect(activity.calories).to eq(400)
        expect(activity.distance).to eq(3.7)
        expect(activity.dollars_saved).to eq(1.97)
        expect(activity.drink_type).to eq("IPA")
        expect(activity.lbs_carbon_saved).to eq(1.2)
        expect(activity.num_drinks).to eq(2)
        expect(activity.user_id).to eq(5)
        expect(activity.created_at).to eq("2023-01-09 18:10:07")
      end
    end
  end
end