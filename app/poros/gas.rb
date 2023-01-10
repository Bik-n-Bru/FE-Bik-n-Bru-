class Gas
  attr_reader :gas_price
  def initialize(data)
    @gas_price = data[:data][:gas_price]
  end
end