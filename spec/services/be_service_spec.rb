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
  end

  xdescribe "location_update" do
    it "should update the signed in users city and state with Strava" do
      @user_input = {
        data: {
          athlete_id: '27272687',
          username: 'StevePrefontaine',
          token: '6b16d87c382z7b979965dbc28b9qbfc47197c2d9',
          city: 'Eugene',
          state: 'Oregon'
        }
      }
      
      expect(@user_input[:data][:city]).to eq("Eugene")
      expect(@user_input[:data][:state]).to eq("Oregon")
      
      update_user_input = {
        data: {
          
          city: 'Bend',
          state: 'Oregon'
        }
      }
      user_update_response = BEService.location_update("Bend", "Oregon", "4")
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
end 