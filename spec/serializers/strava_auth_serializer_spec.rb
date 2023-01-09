require 'rails_helper'

RSpec.describe StravaAuthSerializer do

  before :each do
    @strava_response = {:token_type=>"Bearer",
    :expires_at=>1672945340,
    :expires_in=>13803,
    :refresh_token=>"76a56453e80a176kdcb483728dw6d192adf3cf67",
    :access_token=>"a2dbd0170e11f816zd2407q6342d81b83f33a052",
    :athlete=>
     {:id=>21293819,
      :username=>"sprefontaine",
      :resource_state=>2,
      :firstname=>"Steve",
      :lastname=>"Prefontaine",
      :bio=>
       "\"To give anything less than your best is to sacrifice the gift.\"",
      :city=>"Eugene",
      :state=>"Oregon",
      :country=>"United States",
      :sex=>"M",
      :premium=>false,
      :summit=>false,
      :created_at=>"1972-05-28T16:40:14Z",
      :updated_at=>"2021-01-04T18:41:27Z",
      :badge_type_id=>0,
      :weight=>0.0,
      :friend=>nil,
      :follower=>nil}}
  end

  describe 'class methods' do
    describe 'serialize' do
      it 'returns the user data in a standardized format' do
        serialized_user = StravaAuthSerializer.serialize(@strava_response)

        expect(serialized_user[:data][:username]).to eq("#{@strava_response[:athlete][:firstname]} #{@strava_response[:athlete][:lastname]}")
        expect(serialized_user[:data][:token]).to eq(@strava_response[:access_token])
        expect(serialized_user[:data][:athlete_id]).to eq(@strava_response[:athlete][:id])
      end
    end
  end
end