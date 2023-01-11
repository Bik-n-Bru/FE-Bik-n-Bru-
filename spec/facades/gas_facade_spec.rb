require 'rails_helper'

RSpec.describe GasFacade do
  describe 'class methods' do
    describe '#gas_price' do
      it 'should return gas_price object' do
        user = {data: {id: "1", type: "user", attributes: {username: "SPrefontaine", token: "12345abcde", athlete_id: "12345", city: "Eugene", state: "Oregon"}, relationships:{activities:{data:[]},badges:{data:[]}}}}
        oregon_gas = {data: {state: "oregon",gas_price: "3.270"}}
   
        stub_request(:get, "https://be-bik-n-bru.herokuapp.com/api/v1/gas_price/1").to_return(body: oregon_gas.to_json)
        
        g_price = GasFacade.price("1")

        expect(g_price.gas_price).to eq(3.27)
        expect(g_price.state).to eq("oregon")
      end
    end
  end
end