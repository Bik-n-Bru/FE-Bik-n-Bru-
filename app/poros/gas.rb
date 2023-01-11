class Gas
  attr_reader :state,
              :gas_price
  def initialize(data)
    @state = data[:data][:state]
    @gas_price = format_price(data[:data][:gas_price])
  end

  def format_price(price)
    (price.to_f).round(2)
  end
end