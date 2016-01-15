require "test_helper"

class GuestCantViewProfileTest < ActionDispatch::IntegrationTest

  test "guest is redirected to home page when they visit '/profile'" do
    visit profile_path

    assert_equal root_path, current_path
  end

end
