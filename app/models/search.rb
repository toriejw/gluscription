class Search < ActiveRecord::Base
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

  def self.return_results(drug)
    Drug.new(drug)
  end

  def self.not_found_notice
    "<p class='not-found-notice'>Sorry, we could not find the medication you searched for.</p>"
  end

  # def save(drug)
  #   return unless drug.found?
  #
  #   search = Search.create( medication: drug.name,
  #                                        gluten_free_status: drug.gluten_free?.to_s )
  #
  #   drug.dangerous_ingredients.each do |ingredient|
  #     search.suspect_ingredients.create(name: ingredient)
  #   end
  # end
end
