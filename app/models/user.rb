class User < ActiveRecord::Base
  has_many :searches

  def self.from_omniauth(user_data)
    user      = find_or_create_by(third_party_id: user_data["uid"])
    user.name = user_data["info"]["first_name"]
    user.save!
    user
  end

  def save_search(drug)
    return if ( !drug.found? || self.already_searched?(drug) )

    search = Search.save(drug)
    self.searches << search
  end

  def already_searched?(drug)
    self.searches.find_by(medication: drug.name)
  end

end
