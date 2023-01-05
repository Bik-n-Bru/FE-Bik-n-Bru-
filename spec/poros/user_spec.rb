require 'rails_helper'

RSpec.describe User do
  before :each do
    @user_input = {
      data: {
        id: '1',
        attributes: {
          athlete_id: '27272687',
          username: 'StevePrefontaine',
          token: '6b16d87c382z7b979965dbc28b9qbfc47197c2d9',
          city: 'Eugene',
          state: 'Oregon'
        }
      }
    }
    @user = User.new(@user_input)
  end
  describe 'initialize' do
    it 'has readable attributes' do
      expect(@user.id).to eq(@user_input[:data][:id])
      expect(@user.athlete_id).to eq(@user_input[:data][:attributes][:athlete_id])
      expect(@user.username).to eq(@user_input[:data][:attributes][:username])
      expect(@user.token).to eq(@user_input[:data][:attributes][:token])
      expect(@user.city).to eq(@user_input[:data][:attributes][:city])
      expect(@user.state).to eq(@user_input[:data][:attributes][:state])
    end
  end
end