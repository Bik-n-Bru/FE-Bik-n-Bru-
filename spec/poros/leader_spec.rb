require 'rails_helper'

RSpec.describe Leader do
  describe 'initialize' do
    it 'has readable attributes' do
      leader_data = {
        attributes: {
          username: 'Lance',
          miles: '12897',
          beers: '527',
          co2_saved: '61'
        }
      }

      leader = Leader.new(leader_data)

      expect(leader.username).to eq(leader_data[:attributes][:username])
      expect(leader.miles).to eq(leader_data[:attributes][:miles])
      expect(leader.beers).to eq(leader_data[:attributes][:beers])
      expect(leader.co2_saved).to eq(leader_data[:attributes][:co2_saved])
    end
  end
end