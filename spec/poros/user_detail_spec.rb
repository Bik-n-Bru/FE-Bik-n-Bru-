require 'rails_helper'

RSpec.describe UserDetail do

  before :each do
    @user_data = {
      data: {
          id: "1",
          type: "user",
          attributes: {
              username: "testcase",
              token: "12345abcde",
              athlete_id: "12345",
              city: "",
              state: ""
          },
          relationships: {
              activities: {
                  data: []
              },
              badges: {
                data: []
              }
          }
      }
  }

  @user_badges = {:data=>['Visited 10 breweries', 'Completed 1 Activity']}
  b1 = Brewery.new({:id=>"agrarian-ales-llc-eugene", :type=>"brewery", :attributes=>{:name=>"Agrarian Ales, LLC", :street_address=>"31115 W Crossroads Ln", :city=>"Eugene", :state=>"Oregon", :zipcode=>"97408-9220", :phone=>"5416323803", :website_url=>"http://www.agales.com"}})
  b2 = Brewery.new({:id=>"alesong-brewing-and-blending-eugene", :type=>"brewery", :attributes=>{:name=>"Alesong Brewing and Blending", :street_address=>"1000 Conger St Ste C", :city=>"Eugene", :state=>"Oregon", :zipcode=>"97402-2950", :phone=>"5419723303", :website_url=>"http://www.alesongbrewing.com"}})
  
  @breweries = [b1, b2]

  end

  describe 'initialize' do
    it 'has readable attributes' do
      user_detail = UserDetail.new(@user_data, @user_badges, @breweries)

      expect(user_detail.id).to eq(@user_data[:data][:id])
      expect(user_detail.username).to eq(@user_data[:data][:attributes][:username])
      expect(user_detail.athlete_id).to eq(@user_data[:data][:attributes][:athlete_id])
      expect(user_detail.city).to eq(@user_data[:data][:attributes][:city])
      expect(user_detail.state).to eq(@user_data[:data][:attributes][:state])
      expect(user_detail.activities).to be_a Array
      expect(user_detail.badges).to eq(@user_badges[:data])
      expect(user_detail.breweries).to be_a Array
      
      user_detail.breweries.each do |brewery|
        expect(brewery).to be_a Brewery
      end
    end
  end
end