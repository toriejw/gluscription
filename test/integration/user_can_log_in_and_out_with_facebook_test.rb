require "test_helper"

class UserCanLoginWithFacebookTest < ActionDispatch::IntegrationTest

  test "existing user can log in using facebook and log out" do
    stub_omniauth
    visit root_path
    click_link "Log in with Facebook"

    assert_equal "/profile", current_path
    assert page.has_content? "Hi, some_name. Here are your past searches:"

    click_link "Log out"
    visit "/profile"

    refute page.has_content? "Hi, some_name. Here are your past searches:"

    click_link "Log in with Facebook"

    assert_equal "/profile", current_path
    assert page.has_content? "Hi, some_name. Here are your past searches:"
  end

  test "new user can log in and account will be created" do
    skip
    old_user_count = User.count
    stub_omniauth

    visit root_path
    click_link "Log in with Facebook"

    assert_equal "/profile", current_path
    assert page.has_content? "Hi, some_name. Here are your past searches:"

    new_user_count = User.count

    assert_equal 1, new_user_count - old_user_count
  end

end
