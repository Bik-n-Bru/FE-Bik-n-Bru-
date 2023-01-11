require 'rails_helper'

RSpec.describe UsersFacade do
  describe 'class methods' do
    describe '#user_detail' do
      it 'returns UserDetail object' do
        VCR.use_cassette('user_facade') do
          user_detail = UsersFacade.user_detail('1')
          expect(user_detail).to be_a UserDetail
          expect(user_detail.breweries).to be_a Array
  
          user_detail.breweries.each do |brewery|
            expect(brewery).to be_a Brewery
          end
  
          user_detail.activities.each do |activity|
            expect(activity).to be_a Activity
          end
  
          user_detail.badges.each do |badge|
            expect(badge).to be_a Badge
          end
        end
      end

      it 'returns a max of 10 brewery objects' do
        VCR.use_cassette('user_detail_with_activities') do
          user_details = UsersFacade.user_detail('5')
  
          expect(user_details.breweries.size).to eq(50)
        end
      end
    end
  end
end