require "rails_helper"

feature "user can save searches" do
  scenario "user can save successful searches and view them on their profile", js: true do
    old_search_count = Search.count
    stub_omniauth

    visit root_path
    click_link "Log in with Facebook"
    click_button "New Search"

    expect(current_path).to eq(root_path)

    fill_in "drug", with: "torie"
    click_button "Search"

    click_link "My Searches"

    expect(page).to have_content("You don't have any saved searches yet.")

    click_button "New Search"
    fill_in "drug", with: "p"
    click_button "Search"

    click_link "My Searches"

    expect(page).to have_content("Medication")
    expect(page).to have_content("Gluten-free?")
    expect(page).to have_content("Suspect Ingredients")

    expect(page).to have_content("SIMETHICONE 66.7 MG/ML ORAL SUSPENSION")
    expect(page).to have_content("Yes")
    expect(page).to have_content("none")

    new_search_count = Search.count

    expect(new_search_count - old_search_count).to eq(1)
  end
end
