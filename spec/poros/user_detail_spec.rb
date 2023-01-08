require 'rails_helper'

RSpec.describe UserDetail do

  before :each do
    @user_data = {
      data: {
          id: "1",
          type: "user",
          attributes: {
              username: "testcase",
              token: "12345abcde",
              athlete_id: "12345",
              city: "",
              state: ""
          },
          relationships: {
              activities: {
                  data: []
              },
              badges: {
                data: []
              }
          }
      }
  }

  @user_badges = {:data=>['Visited 10 breweries', 'Completed 1 Activity']}

  end
  describe 'initialize' do
    it 'has readable attributes' do
      user_detail = UserDetail.new(@user_data, @user_badges)

      expect(user_detail.id).to eq(@user_data[:data][:id])
      expect(user_detail.username).to eq(@user_data[:data][:attributes][:username])
      expect(user_detail.athlete_id).to eq(@user_data[:data][:attributes][:athlete_id])
      expect(user_detail.city).to eq(@user_data[:data][:attributes][:city])
      expect(user_detail.state).to eq(@user_data[:data][:attributes][:state])
      expect(user_detail.activities).to be_a Array
      expect(user_detail.badges).to eq(@user_badges[:data])
    end
  end
end