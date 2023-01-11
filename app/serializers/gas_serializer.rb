class GasSerializer
  def self.serialize_gas(state, gas_price)
    {
    data: {
        state: state,
        gas_price: gas_price
      }
    }
  end
end