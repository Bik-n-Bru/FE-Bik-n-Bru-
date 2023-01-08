require 'rails_helper'

RSpec.describe UsersFacade do
  describe 'class methods' do
    describe '#user_detail' do
      it 'returns UserDetail object' do
        user_data = {data:{id:1,type: 'user',attributes:{username: 'testcase',token: '12345abcde',athlete_id: '12345',city: 'Bend',state: 'Oregon'},relationships:{activities:{data:[]},badges:{data:[]}}}}
        badges_data = {:data=>['Visited 10 breweries', 'Completed 1 Activity']}

        stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/1').to_return(body: user_data.to_json)
        stub_request(:get, 'https://be-bik-n-bru.herokuapp.com/api/v1/users/1/badges').to_return(body: badges_data.to_json)

        user_detail = UsersFacade.user_detail('1')
        expect(user_detail).to be_a UserDetail
      end 
    end
  end
end