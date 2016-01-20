class User < ActiveRecord::Base
  has_many :searches

  def self.from_omniauth(user_data)
    user      = find_or_create_by(third_party_id: user_data["uid"])
    user.name = user_data["info"]["first_name"]
    user.save!
    user
  end

  def save_search(drug)
    return unless drug.found?

    search = Search.create( medication: drug.name,
                            gluten_free_status: drug.gluten_free?.to_s )

    drug.dangerous_ingredients.each do |ingredient|
      search.suspect_ingredients.create(name: ingredient)
    end

    self.searches << search
  end

end
