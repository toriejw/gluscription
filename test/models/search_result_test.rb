require 'test_helper'

class SearchTest < ActiveSupport::TestCase

  def create_search_with_ingredients
    result = Search.create(medication: "tylenol")

    result.suspect_ingredients << [ SuspectIngredient.create(name: "rye"),
                                    SuspectIngredient.create(name: "starch") ]

    result
  end

  test "it can return formatted string of all its suspect ingredients" do
    result = create_search_with_ingredients

    assert_equal "rye, starch", result.suspect_ingredients_formatted
  end
end
