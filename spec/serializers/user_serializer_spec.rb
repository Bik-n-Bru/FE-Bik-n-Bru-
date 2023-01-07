require 'rails_helper'

RSpec.describe UserSerializer do
  describe 'class methods' do
    describe '#serialize_user' do
      it 'returns a formatted hash' do

        serialized_user = UserSerializer.serialize_user('Dallas', 'Texas')

        expect(serialized_user[:user]).to be_a Hash
        expect(serialized_user[:user][:data]).to be_a Hash
        expect(serialized_user[:user][:data][:city]).to eq('Dallas')
        expect(serialized_user[:user][:data][:state]).to eq('Texas')
      end
    end
  end
end