require 'test_helper'

class DrugTest < ActiveSupport::TestCase

  test "it can find its name from search terms" do
    drug = Drug.new("b")

    assert_equal "Camphor 62 MG/ML Inhalant Solution", drug.name
  end

  test "it can return its rxcui code" do
    drug = Drug.new("b")

    assert_equal "701961", drug.rxcui
  end

  test "it can return a list of ingredients" do
    drug                 = Drug.new("c")
    actual_ingredients   = drug.full_ingredient_list
    expected_ingredients = "inactive ingredients fd&c green #3 dye usp purified water active ingredients chlorhexidine gluconate 2% w/v isopropyl alcohol 70% v/v"

    assert_equal String, actual_ingredients.class
    assert_equal expected_ingredients, actual_ingredients
  end

  test "it knows whether or not it's gluten free" do
    warfarin         = Drug.new("warfarin")
    tylenol          = Drug.new("tylenol")
    drug_with_gluten = Drug.new("rye")

    assert_equal :yes, warfarin.gluten_free?
    assert_equal :maybe, tylenol.gluten_free?
    assert_equal :no, drug_with_gluten.gluten_free?
  end

  test "it knows if ingredient list is unavailable" do
    bee_venom = Drug.new("ra")

    assert_equal :ingredients_not_listed, bee_venom.gluten_free?
  end

end
