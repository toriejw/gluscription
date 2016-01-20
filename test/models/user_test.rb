require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "it can save a search" do
    user = User.create(name: "Dog")
    old_user_search_count = user.searches.count

    user.save_search(Drug.new("hi"))

    new_user_search_count = user.searches.count
    saved_result = user.searches.first

    assert_equal 1, new_user_search_count - old_user_search_count

    assert_equal "chloroxylenol 3.75 MG/ML Medicated Liquid Soap", saved_result.medication
    assert_equal "yes", saved_result.gluten_free_status
    assert_equal [], saved_result.suspect_ingredients
  end

end
