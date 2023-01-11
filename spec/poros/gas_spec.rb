require 'rails_helper'

RSpec.describe Gas do
  describe 'initialize' do
    it "has attributes" do
      gas_data =  
      {
        data: {
          state: "oregon",
          gas_price: "3.270"
        }
      }
      gas = Gas.new(gas_data)
     
      expect(gas.state).to eq(gas_data[:data][:state])
      expect(gas.gas_price).to eq(3.27)
    end
  end

end