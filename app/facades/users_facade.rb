class UsersFacade
  def self.user_detail(user_id)
    user_json = BEService.find_user(user_id)
    UserDetail.new(user_json)
  end
end