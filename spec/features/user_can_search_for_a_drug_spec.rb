require "rails_helper"

feature "user can search for a drug" do
  scenario "user can search for a drug from the home page and receive maybe gluten-free notice", js: true do
    visit root_path

    expect(current_path).to eq("/")
    expect(page).to have_content("Type in the name of a prescription or OTC drug")
    expect(page).to have_content("Drug information comes from the FDA, who provide it with the following disclaimer")
    expect(page).to have_button("Search")

    fill_in "drug", with: "tylenol"
    click_button "Search"

    expect(current_path).to eq("/")
    expect(page).to have_content("ACETAMINOPHEN 500 MG ORAL CAPSULE [MAPAP] may or may not be gluten-free.")
    expect(page).to have_content("Ingredients of concern: starch")
  end

  scenario "user can search for a drug from the home page and receive gluten-free notice", js: true do
    visit root_path

    fill_in "drug", with: "hi"
    click_button "Search"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("is gluten-free!")
    expect(page).to have_content("Ingredients of concern: none")
  end

  scenario "user can search for a drug from the home page and receive not gluten-free notice", js: true do
    visit root_path

    fill_in "drug", with: "rye"
    click_button "Search"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("is NOT gluten-free :( !")
    expect(page).to have_content("Ingredients of concern: rye")
  end

  scenario "user sees not found notice when they search for a drug with no data", js: true do
    visit root_path

    fill_in "drug", with: "ra"
    click_button "Search"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sorry, the FDA has not provided ingredients for this drug :(")
  end

  scenario "user sees not found notice when they search for a drug that's not in the database", js: true do
    visit root_path

    fill_in "drug", with: "synthroid"
    click_button "Search"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sorry, we could not find the medication you searched for.")
  end

  scenario "user sees not found notice when they search for a drug that doesn't return an rxcui", js: true do
    visit root_path

    fill_in "drug", with: "t"
    click_button "Search"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Sorry, we could not find the medication you searched for.")
  end
end
