class Badge
  attr_reader :title

  def initialize(badge_json)
    @title = badge_json[:attributes][:title]
  end
end