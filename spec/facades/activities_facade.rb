require 'rails_helper'

RSpec.describe ActivityFacade do
  describe 'class methods' do

    describe "#create_activity" do
    describe '#find_activity' do
      it 'returns a single activity object' do
        user_id = "1"
        activity_id = "1"
        activity = ActivityFacade.find_activity(user_id, activity_id)

        expect(activity).to be_an_instance_of(Array)
        expect(activity.id).to eq("10-barrel-brewing-co-bend-1")
        expect(activity.name).to eq("10 Barrel Brewing Co")
        expect(activity.street_address).to eq("62970 18th St")
        expect(activity.city).to eq("Bend")
        expect(activity.state).to eq("Oregon")
        expect(activity.zip_code).to eq("97701-9847")
        expect(activity.phone_number).to eq("5415851007")
        expect(activity.id).to eq("10-barrel-brewing-co-bend-2")

        expect(breweries.count).to_not eq(50)
        expect(breweries[2].id).to_not eq("10-barrel-brewing-co-bend-1")
      end
    end 
  end
end