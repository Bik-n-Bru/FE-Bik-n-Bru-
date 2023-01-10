require 'rails_helper'

RSpec.describe Badge do
  describe 'initialize' do
    it 'has readable attributes' do
      badge_json = {:id=>"41", :type=>"badge", :attributes=>{:title=>"Completed 1 Activity"}, :relationships=>{:user=>{:data=>{:id=>"5", :type=>"user"}}}}
      badge = Badge.new(badge_json)

      expect(badge.title).to eq(badge_json[:attributes][:title])
    end
  end
end