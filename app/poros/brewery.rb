class Brewery
  attr_reader :name, :address, :phone_number, :website, :type
  
  def initialize(data)
    @name = data[:attributes][:name]
    @address = data[:attributes][:name]
    @phone_number = data[:attributes][:name]
    @website = data[:attributes][:name]
    @type = data[:attributes][:name]
  end

end