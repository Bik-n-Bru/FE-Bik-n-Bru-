require 'rails_helper'

RSpec.describe UsersFacade do
  describe 'class methods' do
    describe '#user_detail' do
      it 'returns UserDetail object' do
        VCR.use_cassette('find_user') do
          user_detail = UsersFacade.user_detail('1')
          expect(user_detail).to be_a UserDetail
        end
      end 
    end
  end
end