require "test_helper"

class UserCanLoginWithFacebookTest < ActionDispatch::IntegrationTest

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        provider: "facebook",
        uid: "1234",
        info: { first_name: "some_name" },
        credentials: { token: "candy_treats",
                       expires_at: 1010101,
                       expires: "true" } })
  end

  test "user can log in to facebook from the nav bar" do
    stub_omniauth
    visit root_path
    click_link "Log in with Facebook"

    assert_equal "/profile", current_path
    assert page.has_content? "Hi, some_name. Here are your past searches:"
  end

end
