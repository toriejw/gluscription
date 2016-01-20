require "test_helper"

class UserCanLoginWithFacebookTest < ActionDispatch::IntegrationTest

  test "existing user can log in using facebook and log out" do
    stub_omniauth
    visit root_path
    click_link "Log in with Facebook"

    assert_equal "/profile", current_path
    assert page.has_content? "Hi, some_name. Here are your past searches:"

    click_link "Log Out"

    assert_equal root_path, current_path
    assert page.has_content? "You have successfully logged out."

    visit "/profile"

    refute page.has_content? "Hi, some_name. Here are your past searches:"

    old_user_count = User.count

    click_link "Log in with Facebook"

    new_user_count = User.count

    assert_equal "/profile", current_path
    assert page.has_content? "Hi, some_name. Here are your past searches:"
    assert_equal 0, old_user_count - new_user_count
  end

  # test "new user can log in and account will be created" do
  #   old_user_count = User.count
  #   stub_omniauth
  #
  #   visit root_path
  #   click_link "Log in with Facebook"
  #
  #   assert_equal "/profile", current_path
  #   assert page.has_content? "Hi, some_name. Here are your past searches:"
  #
  #   new_user_count = User.count
  #
  #   assert_equal 1, new_user_count - old_user_count
  # end

end
