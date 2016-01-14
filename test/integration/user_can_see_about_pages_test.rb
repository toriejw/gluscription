require "test_helper"

class UserCanSeeAboutPagesTest < ActionDispatch::IntegrationTest

  test "user can navigate to about page from home" do
    visit root_path
    click_link "About Gluscription"

    assert_equal about_path, current_path
    assert page.has_content? "Who we are"
    assert page.has_content? "How we determine if a drug is gluten-free"
  end

end
