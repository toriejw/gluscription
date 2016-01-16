class SearchResult < ActiveRecord::Base
  belongs_to :user
  has_many :suspect_ingredients

  def suspect_ingredients_formatted
    self.suspect_ingredients.pluck(:name).join(", ")
  end
end
