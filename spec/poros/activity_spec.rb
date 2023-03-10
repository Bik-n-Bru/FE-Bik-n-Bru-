require 'rails_helper'

RSpec.describe Activity do
  describe 'initialize' do
    it 'has readable attributes' do
      activity_data = {id:'1', attributes:{brewery_name:'Wild Corgi Pub', distance: 5.1, calories: 521, num_drinks: 3, drink_type: 'Domestic', dollars_saved: 2.71, lbs_carbon_saved: 1.6, user_id: 5, created_at: "2023-01-10 04:24:35"}}
      activity_data = {id:'1', attributes:{brewery_name:'Wild Corgi Pub', distance: 5.1, calories: 521, num_drinks: 3, drink_type: 'Domestic', dollars_saved: 2.71, lbs_carbon_saved: 1.6, user_id: 5, created_at: "2023-01-09 18:10:07"}}
      activity = Activity.new(activity_data)

      expect(activity.id).to eq(activity_data[:id])
      expect(activity.brewery_name).to eq(activity_data[:attributes][:brewery_name])
      expect(activity.distance).to eq(activity_data[:attributes][:distance])
      expect(activity.calories).to eq(activity_data[:attributes][:calories])
      expect(activity.num_drinks).to eq(activity_data[:attributes][:num_drinks])
      expect(activity.drink_type).to eq(activity_data[:attributes][:drink_type])
      expect(activity.dollars_saved).to eq(activity_data[:attributes][:dollars_saved])
      expect(activity.lbs_carbon_saved).to eq(activity_data[:attributes][:lbs_carbon_saved])
      expect(activity.user_id).to eq(activity_data[:attributes][:user_id])
      expect(activity.created_at).to eq("Monday, January 09, 2023")
    end
  end

  describe "class methods" do
    describe "#format date" do
      it "formats the date to be 'Day-of-the-week, Month, date(2 digits), year(4 digits)" do
        activity_data = {id:'1', attributes:{brewery_name:'Wild Corgi Pub', distance: 5.1, calories: 521, num_drinks: 3, drink_type: 'Domestic', dollars_saved: 2.71, lbs_carbon_saved: 1.6, user_id: 5, created_at: "2023-01-09 18:10:07"}}
        activity = Activity.new(activity_data)

        expect(activity.created_at).to eq("Monday, January 09, 2023")
        expect(activity.created_at).to_not eq("Tuesday, January 10, 2024")
      end
    end
  end
end