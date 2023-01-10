class GasFacade
  def self.price(state)
    results = BEService.gas_price(state)
    Gas.new(results)
  end 
end