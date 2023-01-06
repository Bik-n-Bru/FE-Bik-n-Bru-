require 'rails_helper'

RSpec.describe LeadersFacade do
  describe 'class methods' do
    describe 'leaderboard' do
      it 'returns an array of leader objects' do
        leaderboard_data = {
          data: [
            {
              attributes: {
                username: 'SPrefontaine',
                miles: '19897',
                beers: '723',
                co2_saved: '93'
              }
            },
            {
              attributes: {
                username: 'Lance',
                miles: '12897',
                beers: '527',
                co2_saved: '61'
              }
            },
            {
              attributes: {
                username: 'Kenny',
                miles: '10297',
                beers: '438',
                co2_saved: '51'
              }
            }
          ]
        }

        leaders = LeadersFacade.leaderboard(leaderboard_data)

        expect(leaders.size).to eq(3)
        leaders.each do |leader|
          expect(leader).to be_a Leader
        end
      end
    end
  end
end