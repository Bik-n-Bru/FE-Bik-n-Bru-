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

  # xdescribe "#user_activities" do
  #   it "returns json data that is a list of the specified users activities" do
  #     VCR.use_cassette('login_user') do
  #       @user_output = BEService.login_user(@user_input)
  #     end
  #     results = BEService.user_activities(@user_output[:data][:id])

  #     expect(results[:data]).to be_a(Hash)
  #     expect(results[:data][0][:attributes][:brewery_name]).to be_a(String)
  #     expect(results[:data][0][:attributes][:distance]).to be_a(Float)
  #     expect(results[:data][0][:attributes][:calories]).to be_a(Integer)
  #     expect(results[:data][0][:attributes][:num_drinks]).to be_a(Integer)
  #     expect(results[:data][0][:attributes][:drink_type]).to be_a(String)
  #     expect(results[:data][0][:attributes][:dollars_saved]).to be_a(Float)
  #     expect(results[:data][0][:attributes][:lbs_carbon_saved]).to be_a(Float)
  #     expect(results[:data][0][:attributes][:user_id]).to be_a(Integer) 
  #   end
  # end

  describe "#create_activity" do
    it "submits an activity post and returns activity json data" do
      VCR.use_cassette('login_user') do
        @user_output = BEService.login_user(@user_input)
      end
      activity_params = {
                        data: {
                          brewery_name: "Emilio Rau MD",
                          drink_type: "IPA",
                          user_id: "#{@user_output[:data][:id]}"
                        }
                      }
     
      activity_json = BEService.create_activity(activity_params)
      binding.pry

      expect(activity_json[:data][:brewery_name]).to eq("Emilio Rau MD")
      expect(activity_json[:data][:drink_type]).to eq("IPA")
      expect(activity_json[:data][:user_id]).to eq("#{@user_output[:data][:id]}")
    end
  end

  xdescribe "#find_user_activity" do
    it "returns json data for a single activty based on the activity_id" do 
      VCR.use_cassette('login_user') do
        @user_output = BEService.login_user(@user_input)
      end
      activity_params = {
                        data: {
                          brewery_name: "Emilio Rau MD",
                          drink_type: "IPA",
                          user_id: "#{@user_output[:data][:id]}"
                        }
                      }
     
      activity = BEService.create_activity(activity_params)
      binding.pry
      activity 
      # post "/api/v1/activities", headers: headers, params: JSON.generate(activity: activity_params)

      stub_request(:any, 'https://be-bik-n-bru.herokuapp.com/activities/1').to_return(body: activity.to_json)
      # activity = {
      #   data: {
      #       id: '1',
      #       type: 'activity',
      #       attributes: {
      #         brewery_name: 'Emilio Rau MD',
      #         distance: '64.14',
      #         calories: '564',
      #         num_drinks: '2',
      #         drink_type: 'Arrogant Bastard Ale',
      #         dollars_saved: '94.53',
      #         lbs_carbon_saved: '41.0',
      #         user_id: '1' },
      #       relationships: {
      #         user: {
      #           data: {
      #             id: "1",
      #             type: "user"
      #           }
      #         }              
      #       }
      #     }
      #   }
      # VCR.use_cassette('login_user') do
      #   @user_output = BEService.login_user(@user_input)
      # end
      #     post "/api/v1/activities", headers: headers, params: JSON.generate(activity: activity_params)

      # stub_request(:any, 'https://be-bik-n-bru.herokuapp.com/activities/1').to_return(body: activity.to_json)

      # @activity_output = BEService.find_activity(activity[:data][:id])
      #   binding.pry
    end
  end
end 