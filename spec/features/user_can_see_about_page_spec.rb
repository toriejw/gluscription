require "rails_helper"

feature "user can see about page" do
  scenario "user can navigate to about page from home" do
    visit root_path
    click_link "About Gluscription"

    expect(current_path).to eq(about_path)
    expect(page).to have_content("Who we are")
    expect(page).to have_content("How we determine if a drug is gluten-free")
  end
end
