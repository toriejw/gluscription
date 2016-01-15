class User < ActiveRecord::Base

  def self.from_omniauth(user_data)
    user      = find_or_create_by(third_party_id: user_data["uid"])
    user.name = user_data["info"]["first_name"]
    user.save!
    user
  end

end
