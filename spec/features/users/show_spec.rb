require 'rails_helper'

RSpec.describe 'The Dashboard Show Page', type: :feature do
  context 'As a logged in user' do
    describe 'when I visit "/dashboard"' do
      before :each do
        visit '/dashboard'
      end
      it 'displays a link to logout, home, and dashboard' do
        expect(page).to have_link('Logout')
        expect(page).to have_link('Home')
        expect(page).to have_link('Dashboard')
      end

      it 'displays a side panel with 10 breweries in the users area'

      it 'displays a link to view more breweries, which redirectes to brewery index page'

    end
  end
end