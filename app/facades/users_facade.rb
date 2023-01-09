class UsersFacade
  def self.user_detail(user_id)
    # user_data = {
    #   data: {
    #         id: "1",
    #         type: "user",
    #         attributes: {
    #               username: "SPrefontaine",
    #               token: "12345abcde",
    #               athlete_id: "12345",
    #               city: "Eugene",
    #               state: "Oregon"
    #           },
    #           relationships: {
    #                 activities: {
    #                       data: []
    #                   },
    #                 }
    #             }
    #         }

    # user_badges = {data: ['Visited 10 breweries', 'Completed 1 Activity', 'Cycled 100 miles', 'Visited 20 breweries']}
            
    #         json = user_data.to_json
    #         user_json = JSON.parse(json, symbolize_names: true)
    #         badges_unparsed = user_badges.to_json
    #         badges_json = JSON.parse(badges_unparsed, symbolize_names: true)
    # b1 = Brewery.new({:id=>"agrarian-ales-llc-eugene", :type=>"brewery", :attributes=>{:name=>"Agrarian Ales, LLC", :street_address=>"31115 W Crossroads Ln", :city=>"Eugene", :state=>"Oregon", :zipcode=>"97408-9220", :phone=>"5416323803", :website_url=>"http://www.agales.com"}})
    # b2 = Brewery.new({:id=>"alesong-brewing-and-blending-eugene", :type=>"brewery", :attributes=>{:name=>"Alesong Brewing and Blending", :street_address=>"1000 Conger St Ste C", :city=>"Eugene", :state=>"Oregon", :zipcode=>"97402-2950", :phone=>"5419723303", :website_url=>"http://www.alesongbrewing.com"}})
    
    # breweries = [b1, b2]

    # a1 = Activity.new({id:'1', attributes:{brewery_name:'Wagon Wheel', distance: 5.1, calories: 521, num_drinks: 3, drink_type: 'Domestic', dollars_saved: 2.71, lbs_carbon_saved: 1.6, user_id: 5}})
    # a2 = Activity.new({id:'1', attributes:{brewery_name:'Wild Corgi Pub', distance: 5.1, calories: 521, num_drinks: 3, drink_type: 'Domestic', dollars_saved: 2.71, lbs_carbon_saved: 1.6, user_id: 5}})
    
    # activities = [a1, a2]

    user_json = BEService.find_user(user_id)
    badges_json = BEService.find_user_badges(user_id)
    breweries = BreweryFacade.user_location_breweries(user_id).first(10)
    activities = ActivitiesFacade.user_activities(user_id)
    UserDetail.new(user_json, badges_json, breweries, activities)
  end
end