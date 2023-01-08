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

    # user_badges = {data: ['Visited 10 breweries', 'Completed 1 Activity', 'Cycled 100 miles']}
            
    #         json = user_data.to_json
    #         user_json = JSON.parse(json, symbolize_names: true)
    #         badges_unparsed = user_badges.to_json
    #         badges_json = JSON.parse(badges_unparsed, symbolize_names: true)

    user_json = BEService.find_user(user_id)
    badges_json = BEService.find_user_badges(user_id)
    breweries = BreweryFacade.user_location_breweries(user_id).first(10)
    UserDetail.new(user_json, badges_json, breweries)
  end
end