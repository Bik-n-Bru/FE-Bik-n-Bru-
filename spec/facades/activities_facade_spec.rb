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
  end
end