require 'test_helper'

class DrugTest < ActiveSupport::TestCase

  test "it can find its name from search terms" do
    VCR.use_cassette("drug#name") do
      drug = Drug.new("b")

      assert_equal "Camphor 62 MG/ML Inhalant Solution", drug.name
    end
  end

  test "it can return its rxcui code" do
    VCR.use_cassette("drug#rxcui") do
      drug = Drug.new("b")

      assert_equal "701961", drug.rxcui
    end
  end

  test "it can return a list of ingredients" do
    VCR.use_cassette("drug#full_ingredient_list") do
      drug                 = Drug.new("c")
      actual_ingredients   = drug.full_ingredient_list
      expected_ingredients = ["inactive", "ingredients", "fd&c", "green", "#3",
                              "dye", "usp", "purified", "water", "active",
                              "ingredients", "chlorhexidine", "gluconate", "2%",
                              "w/v", "isopropyl", "alcohol", "70%", "v/v"]

      assert_equal Array, actual_ingredients.class
      assert_equal expected_ingredients, actual_ingredients
    end
  end

  test "it knows whether or not it's gluten free" do
    VCR.use_cassette("drug#gluten_free?") do
      warfarin         = Drug.new("warfarin")
      tylenol          = Drug.new("tylenol")
      drug_with_gluten = Drug.new("dextrin")

      assert_equal :true, warfarin.gluten_free?
      assert_equal :maybe, tylenol.gluten_free?
      assert_equal :false, drug_with_gluten.gluten_free?
    end
  end

end
