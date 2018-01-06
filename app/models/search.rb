class Search < ActiveRecord::Base
  has_many :suspect_ingredients

  def self.return_results(drug)
    FDADrug.new(drug)
  end

  def self.not_found_notice
    "<p class='not-found-notice'>Sorry, we could not find the medication you searched for.</p>"
  end

  def self.save(drug, search_term)
    search = create_search(drug, search_term)

    add_suspect_ingredients(search, drug)
    search
  end

  def self.save_failed_search(drug_name)
    Search.create( medication: drug_name.downcase,
                   gluten_free_status: "search failed",
                   search_term: drug_name.downcase )
  end

  def suspect_ingredients_formatted
    if self.suspect_ingredients.empty?
      "none"
    else
      unique_ingredients = self.suspect_ingredients.pluck(:name).uniq
      unique_ingredients.map { |ingredient| ingredient.strip }.join(", ")
    end
  end

  private

    def self.create_search(drug, search_term)
      Search.create( medication: drug.name.downcase,
                     gluten_free_status: drug.gluten_free?.to_s,
                     search_term: search_term.downcase )
    end

    def self.add_suspect_ingredients(search, drug)
      drug.dangerous_ingredients.each do |ingredient|
        search.suspect_ingredients.create(name: ingredient)
      end
    end

end
