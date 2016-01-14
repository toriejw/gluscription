require "test_helper"

class UserCanSeeAboutPagesTest < ActionDispatch::IntegrationTest

  test "user can navigate to about page from home" do
    visit root_path
    click_link "About Gluscription"

    assert_equal about_path, current_path
    assert page.has_content? "Who Are We"
  end

  test "user can navigate to 'how we determine if it's gluten-free' page from home" do
    skip
    visit root_path
    click_link "Find out how we determine if a drug is gluten-free"

    assert_equal "/about/our-calculations", current_path
  end

  test "user can navigate to 'how we determine if it's gluten-free' page about" do
    skip
    visit about_path
    click_link "here"

    assert_equal "/about/our-calculations", current_path
  end

end
