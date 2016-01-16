require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "it can save a search" do
    VCR.use_cassette("user#save_search") do
      user = User.create(name: "Dog")
      old_user_search_count = user.search_results.count

      user.save_search(Drug.new("warfarin"))

      new_user_search_count = user.search_results.count
      saved_result = user.search_results.first

      assert_equal 1, new_user_search_count - old_user_search_count

      assert_equal "lansoprazole 15 MG Delayed Release Oral Capsule", saved_result.medication
      assert_equal "yes", saved_result.gluten_free_status
      assert_equal [], saved_result.suspect_ingredients
    end
  end

end
