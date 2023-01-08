class Brewery
  attr_reader :id, :name, :street_address, :city, :state, :zip_code, :phone_number, :website, :type
  
  def initialize(brewery_data)
    @id = brewery_data[:id]
    @name = brewery_data[:attributes][:name]
    @street_address = brewery_data[:attributes][:street_address]
    @city = brewery_data[:attributes][:city]
    @state = brewery_data[:attributes][:state]
    @zip_code = brewery_data[:attributes][:zipcode]
    @phone_number = brewery_data[:attributes][:phone]
    @website = brewery_data[:attributes][:website_url]
    @type = brewery_data[:type]
  end
end
