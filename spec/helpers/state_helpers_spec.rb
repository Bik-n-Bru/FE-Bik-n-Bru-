require "rails_helper"

RSpec.describe StateHelper do

  it "has an array that contains 50 states" do
    expect(us_states.count).to eq(50)
    expect(us_states[0]).to eq('Alabama')
    expect(us_states[49]).to eq('Wyoming')
  end
end