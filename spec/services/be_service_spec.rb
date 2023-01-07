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
  end

  describe "location_update" do
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
      binding.pry
    end
  end
end