require 'test_helper'

class SearchResultTest < ActiveSupport::TestCase

  def create_search_result_with_ingredients
    result = SearchResult.create(medication: "tylenol")

    result.suspect_ingredients << [ SuspectIngredient.create(name: "rye"),
                                    SuspectIngredient.create(name: "starch") ]

    result
  end

  test "it can return formatted string of all its suspect ingredients" do
    VCR.use_cassette("search_result#suspect_ingredients_formatted") do
      result = create_search_result_with_ingredients

      assert_equal "rye, starch", result.suspect_ingredients_formatted
    end
  end
end
