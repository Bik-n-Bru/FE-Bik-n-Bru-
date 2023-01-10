require 'rails_helper'

RSpec.describe ActivitySerializer do
  describe 'class methods' do
    describe '#serialize_activity' do
      it 'returns a serialized activity' do
        activity = ActivitySerializer.serialize_activity('The Pad', 'Pilsner', '1')

        expect(activity).to be_a Hash
        expect(activity[:data]).to be_a Hash
        expect(activity[:data][:brewery_name]).to eq('The Pad')
        expect(activity[:data][:drink_type]).to eq('Pilsner')
        expect(activity[:data][:user_id]).to eq('1')
      end
    end
  end
end