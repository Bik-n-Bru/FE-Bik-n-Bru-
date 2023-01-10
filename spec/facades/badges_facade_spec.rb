require 'rails_helper'

RSpec.describe BadgesFacade do
  describe 'class methods' do
    describe '#user_badges' do
      it 'returns an array of badge objects' do
        VCR.use_cassette('badges') do
          badges = BadgesFacade.user_badges('1')

          expect(badges).to be_a Array
          badges.each do |badge|
            expect(badge).to be_a Badge
          end
        end
      end
    end
  end
end