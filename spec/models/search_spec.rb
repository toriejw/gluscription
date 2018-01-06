require "rails_helper"

RSpec.describe Search, type: :model do

  def create_search_with_ingredients
    result = Search.create(medication: "tylenol")

    result.suspect_ingredients << [ SuspectIngredient.create(name: "rye"),
                                    SuspectIngredient.create(name: "starch") ]

    result
  end

  it "can return formatted string of all its suspect ingredients" do
    result = create_search_with_ingredients

    expect(result.suspect_ingredients_formatted).to eq("rye, starch")
  end

  it "can return unsaved search results" do
    results = Search.return_results("tylenol")

    expect(results.name).to eq("Acetaminophen 500 MG Oral Capsule [Mapap]")
    expect(results.gluten_free?).to eq(:maybe)
  end

  it "can save an instance of a medication" do
    old_saved_results_count = Search.count

    drug         = FDADrug.new("tylenol")
    saved_search = Search.save(drug)

    new_saved_results_count = Search.count

    expect(new_saved_results_count - old_saved_results_count).to eq(1)
    expect(saved_search.medication).to eq("Acetaminophen 500 MG Oral Capsule [Mapap]")
    expect(saved_search.gluten_free_status).to eq("maybe")
    expect(saved_search.suspect_ingredients_formatted).to eq("starch")
  end

  describe "#save_failed_search" do
    it "saves a failed search" do
      search = Search.save_failed_search("drug name")

      expect(search.medication).to eq "drug name"
      expect(search.gluten_free_status).to eq "search failed"
    end
  end

end
