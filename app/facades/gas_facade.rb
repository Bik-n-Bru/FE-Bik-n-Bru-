class GasFacade
  def self.price(state)
    results = BEService.get_gas_price(state)
    Gas.new(results)
  end 
end

