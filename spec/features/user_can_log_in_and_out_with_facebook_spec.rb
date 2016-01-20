require "rails_helper"

feature "user registers and logs in/out with facebook" do
  scenario "they can create an account with facebook" do
    old_user_count = User.count
    stub_omniauth

    visit root_path
    click_link "Log in with Facebook"

    new_user_count = User.count

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Hi, some_name. Here are your past searches:")
    expect(new_user_count - old_user_count).to eq(1)
  end

  scenario "existing user can log in using facebook and log out" do
    stub_omniauth
    visit root_path
    click_link "Log in with Facebook"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Hi, some_name. Here are your past searches:")

    click_link "Log Out"
    visit "/profile"

    expect(current_path).to eq("/")

    old_user_count = User.count

    click_link "Log in with Facebook"

    new_user_count = User.count

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Hi, some_name. Here are your past searches:")
    expect(old_user_count - new_user_count).to eq(0)
  end
end
