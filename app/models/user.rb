class User < ActiveRecord::Base
  has_many :search_results

  def self.from_omniauth(user_data)
    user      = find_or_create_by(third_party_id: user_data["uid"])
    user.name = user_data["info"]["first_name"]
    user.save!
    user
  end

  def save_search(drug)
    return unless valid_search(drug)

    search_results = SearchResult.create( medication: drug.name,
                                          gluten_free_status: drug.gluten_free?.to_s )

    drug.dangerous_ingredients.each do |ingredient|
      search_results.suspect_ingredients.create(name: ingredient)
    end

    self.search_results << search_results
  end

  def valid_search(drug)
    drug.found?
  end
end
