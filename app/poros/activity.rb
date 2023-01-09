require "date"

class Activity
  attr_reader :id,
              :brewery_name,
              :distance,
              :calories,
              :num_drinks,
              :drink_type,
              :dollars_saved,
              :lbs_carbon_saved,
              :user_id,
              :created_at
  
  def initialize(activity_data)
    @id = activity_data[:id]
    @brewery_name = activity_data[:attributes][:brewery_name]
    @distance = activity_data[:attributes][:distance]
    @calories = activity_data[:attributes][:calories]
    @num_drinks = activity_data[:attributes][:num_drinks]
    @drink_type = activity_data[:attributes][:drink_type]
    @dollars_saved = activity_data[:attributes][:dollars_saved]
    @lbs_carbon_saved = activity_data[:attributes][:lbs_carbon_saved]
    @user_id = activity_data[:attributes][:user_id]
    @created_at = activity_data[:attributes][:created_at]
  end

  def format_date
    DateTime.parse(@created_at).strftime("%A, %B %d, %Y")  
  end
end