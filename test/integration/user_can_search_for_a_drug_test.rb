require "test_helper"

class UserCanSearchForADrugTest < ActionDispatch::IntegrationTest
  test "user sees search page as home page" do
    visit root_path

    assert_equal "/", current_path
    assert page.has_content? "Type in the name of a prescription drug"
    assert page.has_content? "Find out how we determine if a drug is gluten-free"
    assert page.has_content? "api disclaimer"
    assert page.has_link? "here"
    assert page.has_button? "SEARCH"
  end
end
