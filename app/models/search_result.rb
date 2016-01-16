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
end
