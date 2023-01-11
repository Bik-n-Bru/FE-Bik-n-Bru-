require 'rails_helper'

RSpec.describe GasFacade do
  describe 'class methods' do
    describe '#gas_price' do
      it 'should return gas_price object' do
        state = "Oregon"
        oregon_gas = {data:{gas_price: "3.270"}}

        stub_request(:get, "https://be-bik-n-bru.herokuapp.com/api/v1/get_gas_price/#{state}").to_return(body: oregon_gas.to_json)
        
        g_price = GasFacade.price("Oregon")

        expect(g_price.gas_price).to eq("3.270")
      end
    end
  end
end