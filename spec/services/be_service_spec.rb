require 'rails_helper'

RSpec.describe BEService do

  before :each do
    @user_input = {
      data: {
        athlete_id: '27272687',
        username: 'StevePrefontaine',
        token: '6b16d87c382z7b979965dbc28b9qbfc47197c2d9',
        city: 'Eugene',
        state: 'Oregon'
      }
    }
  end

  describe 'class methods' do
    describe '#login_user' do
      it 'returns user JSON' do
        VCR.use_cassette('login_user') do
          user_output = BEService.login_user(@user_input)
  
          expect(user_output[:data]).to be_a Hash
          expect(user_output[:data][:id]).to be_a String
          expect(user_output[:data][:attributes][:username]).to be_a String
          expect(user_output[:data][:attributes][:token]).to be_a String
          expect(user_output[:data][:attributes][:athlete_id]).to be_a String
        end
      end
    end

    describe '#leaderboard' do
      it 'returns JSON data of the top 10 users by miles biked with their
      respective miles biked, beers earned, and lbs CO2 saved' do
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
        
        leaderboard_response = BEService.leaderboard
        
        expect(leaderboard_response[:data]).to be_a Array
        expect(leaderboard_response[:data].size).to eq(1)
        
        leaderboard_response[:data].each do |user|
          expect(user[:attributes][:username]).to be_a String
          expect(user[:attributes][:miles]).to be_a String
          expect(user[:attributes][:beers]).to be_a String
          expect(user[:attributes][:co2_saved]).to be_a String
        end
      end
    end
    
    describe '#find_user' do
      it 'returns json data for a given user id' do
        VCR.use_cassette('find_user') do
          user_json = BEService.find_user('1')
          
          expect(user_json[:data]).to be_a Hash
          expect(user_json[:data][:attributes]).to be_a Hash
          expect(user_json[:data][:attributes][:username]).to be_a String
          expect(user_json[:data][:attributes][:athlete_id]).to be_a String
        end
      end
    end
  
    describe '#update_user' do
      it 'submits a User patch returns updated User json data' do
        VCR.use_cassette('update_user') do
          json_patch = {:data=>{:city=>"Eugene", :state=>"Oregon"}}
          user_json = BEService.update_user('5', json_patch)
    
          expect(user_json[:data][:attributes][:city]).to eq('Eugene')
          expect(user_json[:data][:attributes][:state]).to eq('Oregon')
        end
        
        VCR.use_cassette('update_user_again') do
          json_patch = {:data=>{:city=>"New York City", :state=>"New York"}}
          user_json = BEService.update_user('5', json_patch)
          
          expect(user_json[:data][:attributes][:city]).to eq('New York City')
          expect(user_json[:data][:attributes][:state]).to eq('New York')
        end
      end
    end

    describe '#find_user_badges' do
      it "returns json of the user's badges" do
        badges_data = {:data=>['Visited 10 breweries', 'Completed 1 Activity']}
        stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/1/badges').to_return(body: badges_data.to_json)
        
        badges_json = BEService.find_user_badges('1')

        expect(badges_json[:data]).to be_a Array
      end
    end
  end

  describe "#breweries_by_user_location" do
    it "returns json data that is a list of breweries located in that users city and state" do
      VCR.use_cassette('login_user') do
        @user_output = BEService.login_user(@user_input)
      end
      results = BEService.breweries_by_user_location(@user_output[:data][:id])

      expect(results[:data][0][:id]).to eq("10-56-brewing-company-knox")
      expect(results[:data][3][:id]).to eq("10-barrel-brewing-co-bend-pub-bend")
      expect(results[:data][2][:id]).to_not eq("10-barrel-brewing-co-bend-pub-bend")
    end
  end

  describe '#user_activities' do
    it 'returns JSON data of a users activities' do
      activities_data = {data:[{id:'1', attributes:{brewery_name:'Wagon Wheel', distance: 3.7, calories: 400, num_drinks: 2, drink_type: 'IPA', dollars_saved: 1.97, lbs_carbon_saved: 1.2, user_id: 5}},
      {id:'1', attributes:{brewery_name:'Wild Corgi Pub', distance: 5.1, calories: 521, num_drinks: 3, drink_type: 'Domestic', dollars_saved: 2.71, lbs_carbon_saved: 1.6, user_id: 5}}]}

      stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/1/activities').to_return(body: activities_data.to_json)
      activities = BEService.user_activities('5')

      activities[:data].each do |activity|
        expect(activity).to have_key(:id)
        expect(activity[:id]).to be_an(String)
  
        expect(activity).to have_key(:attributes)
        expect(activity[:attributes][:brewery_name]).to be_a(String)
        expect(activity[:attributes][:distance]).to be_a(Float)
        expect(activity[:attributes][:calories]).to be_a(Integer)
        expect(activity[:attributes][:num_drinks]).to be_a(Integer)
        expect(activity[:attributes][:drink_type]).to be_a(String)
        expect(activity[:attributes][:dollars_saved]).to be_a(Float)
        expect(activity[:attributes][:lbs_carbon_saved]).to be_a(Float)
        expect(activity[:attributes][:user_id]).to be_a(Integer)
      end
    end
  end

  describe "#find_activity" do
    it "returns JSON of a single activity from a user" do
      activities_data = {data: {id:'1', attributes:{brewery_name:'Wagon Wheel', distance: 3.7, calories: 400, num_drinks: 2, drink_type: 'IPA', dollars_saved: 1.97, lbs_carbon_saved: 1.2, user_id: 5}}}

      stub_request(:get, "https://be-bik-n-bru.herokuapp.com/api/v1/activities/1").to_return(body: activities_data.to_json)
      
      activity = BEService.find_activity("1")
 
      expect(activity[:data]).to have_key(:id)
      expect(activity[:data]).to have_key(:attributes)
      expect(activity[:data][:attributes][:brewery_name]).to eq("Wagon Wheel")
      expect(activity[:data][:attributes][:distance]).to eq(3.7)
      expect(activity[:data][:attributes][:calories]).to eq(400)
      expect(activity[:data][:attributes][:num_drinks]).to eq(2)
      expect(activity[:data][:attributes][:drink_type]).to eq("IPA")
      expect(activity[:data][:attributes][:dollars_saved]).to eq(1.97)
      expect(activity[:data][:attributes][:lbs_carbon_saved]).to eq(1.2)
      expect(activity[:data][:attributes][:user_id]).to eq(5)
    end
  end
end 