require 'rails_helper'

RSpec.describe UsersFacade do
  describe 'class methods' do
    describe '#user_detail' do
      it 'returns UserDetail object' do
        user_data = {data:{id:1,type: 'user',attributes:{username: 'testcase',token: '12345abcde',athlete_id: '12345',city: 'Bend',state: 'Oregon'},relationships:{activities:{data:[]},badges:{data:[]}}}}
        badges_data = {:data=>['Visited 10 breweries', 'Completed 1 Activity']}
        brewery_data = {:data=>
        [{:id=>"agrarian-ales-llc-eugene",
          :type=>"brewery",
          :attributes=>{:name=>"Agrarian Ales, LLC", :street_address=>"31115 W Crossroads Ln", :city=>"Eugene", :state=>"Oregon", :zipcode=>"97408-9220", :phone=>"5416323803", :website_url=>"http://www.agales.com"}},
         {:id=>"alesong-brewing-and-blending-eugene",
          :type=>"brewery",
          :attributes=>{:name=>"Alesong Brewing and Blending", :street_address=>"1000 Conger St Ste C", :city=>"Eugene", :state=>"Oregon", :zipcode=>"97402-2950", :phone=>"5419723303", :website_url=>"http://www.alesongbrewing.com"}}]}

        stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/1').to_return(body: user_data.to_json)
        stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/1/badges').to_return(body: badges_data.to_json)
        stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/breweries/1').to_return(body: brewery_data.to_json)

        user_detail = UsersFacade.user_detail('1')
        expect(user_detail).to be_a UserDetail
        expect(user_detail.breweries).to be_a Array

        user_detail.breweries.each do |brewery|
          expect(brewery).to be_a Brewery
        end
      end

      it 'returns a max of 10 brewery objects' do
        VCR.use_cassette('user_detail') do
          user_details = UsersFacade.user_detail('5')
  
          expect(user_details.breweries.size).to eq(10)
        end
      end
    end
  end
end