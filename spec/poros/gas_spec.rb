require 'rails_helper'

RSpec.describe Gas do
  describe 'initialize' do
    it "has attributes" do
      gas_data = {data:{gas_price: "3.270"}}

      gas = Gas.new(gas_data)
      expect(gas.gas_price).to eq(gas_data[:data][:gas_price])
    end
  end

end