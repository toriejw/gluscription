require "test_helper"

class UserCanSaveSearchesTest < ActionDispatch::IntegrationTest

  test "user can save searches and view them on their profile" do
    VCR.use_cassette("user-can-save-searche") do
      old_search_count = SearchResult.count
      stub_omniauth
      visit root_path
      click_link "Log in with Facebook"

      click_button "New Search"
      fill_in "drug", with: "warfarin"
      click_button "Search"

      click_link "My Searches"

      assert page.has_content? "Medication"
      assert page.has_content? "Gluten-free?"
      assert page.has_content? "Suspect Ingredients"

      assert page.has_content? "WARFARIN"
      assert page.has_content? "Yes"
      assert page.has_content? "none"

      click_button "New Search"
      fill_in "drug", with: "tylenol"
      click_button "Search"

      click_link "My Searches"

      assert page.has_content? "TYLENOL"
      assert page.has_content? "Maybe"
      assert page.has_content? "starch"

      new_search_count = SearchResult.count

      assert_equal 2, old_search_count - new_search_count
    end
  end

  test "searches for drugs that are not found are not saved" do
    VCR.use_cassette("drugs-not-found-are-not-saved") do
      old_search_count = SearchResult.count
      stub_omniauth
      visit root_path
      click_link "Log in with Facebook"

      click_button "New Search"
      fill_in "drug", with: "torie"
      click_button "Search"

      click_link "My Searches"

      new_search_count = SearchResult.count

      assert page.has_content? "You don't have any saved searches yet."
      assert_equal 0, old_search_count - new_search_count
    end
  end

end
