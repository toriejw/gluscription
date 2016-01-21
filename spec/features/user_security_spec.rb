require "rails_helper"

feature "guest can't view profile" do
  scenario "guest is redirected to home page when they visit '/profile'" do
    visit profile_path

    expect(current_path).to eq(root_path)
  end
end
