class Brewery
  attr_reader :id, :name, :address, :phone_number, :website, :type
  
  def initialize(brewery_data)
    @id = brewery_data[:id]
    @name = brewery_data[:attributes][:name]
    @address = brewery_data[:attributes][:street], 
               brewery_data[:attributes][:city], 
               brewery_data[:attributes][:state],
               brewery_data[:attributes][:postal_code]
    @phone_number = brewery_data[:attributes][:phone]
    @website = brewery_data[:attributes][:website_url]
    @type = brewery_data[:attributes][:brewery_type]
  end

  def phone_number_conversion(phone_number)
    phone_number.insert(3, "-").insert(6, "-")
  end

end


# expect(first_brewery).to eq({
    #     :id=>"10-barrel-brewing-co-denver-denver",
    #     :name=>"10 Barrel Brewing Co - Denver",
    #     :brewery_type=>"large",
    #     :street=>"2620 Walnut St",
    #     :address_2=>nil,
    #     :address_3=>nil,
    #     :city=>"Denver",
    #     :state=>"Colorado",
    #     :county_province=>nil,
    #     :postal_code=>"80205-2231",
    #     :country=>"United States",
    #     :longitude=>"-104.9853655",
    #     :latitude=>"39.7592508",
    #     :phone=>"7205738992",
    #     :website_url=>nil,
    #     :updated_at=>"2023-01-04T04:46:02.393Z",
    #     :created_at=>"2023-01-04T04:46:02.393Z"})
    # end