require "rails_helper"

RSpec.describe Drug, type: :model do

  it "can find its name from search terms" do
    drug = Drug.new("b")

    expect(drug.name).to eq("Camphor 62 MG/ML Inhalant Solution")
  end

  it "can return its rxcui code" do
    drug = Drug.new("b")

    expect(drug.rxcui).to eq("701961")
  end

  it "can return a list of ingredients" do
    drug                 = Drug.new("c")
    actual_ingredients   = drug.full_ingredient_list
    expected_ingredients = "inactive ingredients fd&c green #3 dye usp purified water active ingredients chlorhexidine gluconate 2% w/v isopropyl alcohol 70% v/v"

    expect(expected_ingredients).to eq(actual_ingredients)
  end

  it "knows whether or not it's gluten free" do
    warfarin         = Drug.new("warfarin")
    tylenol          = Drug.new("tylenol")
    drug_with_gluten = Drug.new("rye")

    expect(warfarin.gluten_free?).to eq(:yes)
    expect(tylenol.gluten_free?).to eq(:maybe)
    expect(drug_with_gluten.gluten_free?).to eq(:no)
  end

  it "knows if ingredient list is unavailable" do
    drug_without_ingredients = Drug.new("ra")

    expect(drug_without_ingredients.gluten_free?).to eq(:ingredients_not_listed)
  end

end
