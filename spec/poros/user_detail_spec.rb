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
              }
          }
      }
  }
  end
  describe 'initialize' do
    it 'has readable attributes' do
      user_detail = UserDetail.new(@user_data)

      expect(user_detail.id).to eq(@user_data[:data][:id])
      expect(user_detail.username).to eq(@user_data[:data][:attributes][:username])
      expect(user_detail.athlete_id).to eq(@user_data[:data][:attributes][:athlete_id])
      expect(user_detail.city).to eq(@user_data[:data][:attributes][:city])
      expect(user_detail.state).to eq(@user_data[:data][:attributes][:state])
      expect(user_detail.activities).to be_a Array
    end
  end
end