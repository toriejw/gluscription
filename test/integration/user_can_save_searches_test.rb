require "test_helper"

class UserCanSaveSearchesTest < ActionDispatch::IntegrationTest

  test "user can save searches and view them on their profile" do
    require_js
    old_search_count = Search.count
    stub_omniauth

    visit root_path
    click_link "Log in with Facebook"

    click_button "New Search"

    assert_equal root_path, current_path

    fill_in "drug", with: "hi"
    click_button "Search"

    click_link "My Searches"

    assert page.has_content? "Medication"
    assert page.has_content? "Gluten-free?"
    assert page.has_content? "Suspect Ingredients"

    assert page.has_content? "CHLOROXYLENOL 3.75 MG/ML MEDICATED LIQUID SOAP"
    assert page.has_content? "Yes"
    assert page.has_content? "none"

    click_button "New Search"
    fill_in "drug", with: "tylenol"
    click_button "Search"

    click_link "My Searches"

    assert page.has_content? "ACETAMINOPHEN 500 MG ORAL CAPSULE [MAPAP]"
    assert page.has_content? "Maybe"
    assert page.has_content? "starch"

    new_search_count = Search.count

    assert_equal 2, new_search_count - old_search_count

    click_link "Log Out"
  end

  # test "searches for drugs that are not found are not saved" do
  #   require_js
  #   old_search_count = Search.count
  #   stub_omniauth
  #
  #   visit root_path
  #   click_link "Log in with Facebook"
  #
  #   assert_equal profile_path, current_path
  #
  #   click_button "New Search"
  #   fill_in "drug", with: "torie"
  #   click_button "Search"
  #
  #   click_link "My Searches"
  #
  #   new_search_count = Search.count
  #
  #   assert page.has_content? "You don't have any saved searches yet."
  #   assert_equal 0, old_search_count - new_search_count
  #
  #   click_link "Log Out"
  # end

end
