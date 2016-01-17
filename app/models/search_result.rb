class SearchResult < ActiveRecord::Base
  belongs_to :user
  has_many :suspect_ingredients

  def suspect_ingredients_formatted
    if self.suspect_ingredients.empty?
      "none"
    else
      unique_ingredients = self.suspect_ingredients.pluck(:name).uniq
      unique_ingredients.map { |ingredient| ingredient.strip }.join(", ")
    end
  end

  # def save(drug)
  #   return unless drug.found?
  #
  #   search_result = SearchResult.create( medication: drug.name,
  #                                        gluten_free_status: drug.gluten_free?.to_s )
  #
  #   drug.dangerous_ingredients.each do |ingredient|
  #     search_result.suspect_ingredients.create(name: ingredient)
  #   end
  # end
end
