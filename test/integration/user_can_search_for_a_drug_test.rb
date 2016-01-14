require "test_helper"

class UserCanSearchForADrugTest < ActionDispatch::IntegrationTest
  test "user can search for a drug from the home page and receive maybe gluten-free notice" do
    VCR.use_cassette("maybe-gf-drug-search-integration-test") do
      visit root_path

      assert_equal "/", current_path
      assert page.has_content? "Type in the name of a prescription or OTC drug"
      assert page.has_link? "Find out how we determine if a drug is gluten-free"
      assert page.has_content? "Drug information comes from the FDA, who provide it with the following disclaimer"
      assert page.has_button? "Search"

      fill_in "drug", with: "tylenol"
      click_button "Search"

      assert_equal result_path, current_path

      assert page.has_content?("ACETAMINOPHEN 500 MG ORAL CAPSULE [MAPAP] may or may not be gluten-free.")
      # assert page.has_content?("Ingredients that may contain gluten:")
      # assert page.has_content?("None! :)")
    end
  end

  test "user can search for a drug from the home page and receive gluten-free notice" do
    VCR.use_cassette("gf-drug-search-integration-test") do
      visit root_path

      fill_in "drug", with: "warfarin"
      click_button "Search"

      assert_equal result_path, current_path

      assert page.has_content?("is gluten-free!")
    end
  end

  test "user can search for a drug from the home page and receive not gluten-free notice" do
    VCR.use_cassette("non-gf-drug-search-integration-test") do
      visit root_path

      fill_in "drug", with: "rye"
      click_button "Search"

      assert_equal result_path, current_path

      assert page.has_content?("is NOT gluten-free :( !")
    end
  end

  # test "user sees not found notice when they search for a drug with no data" do
  #   VCR.use_cassette("drug-search-no-data") do
  #     visit root_path
  #
  #     fill_in "drug", with: "bee venom"
  #     click_button "Search"
  #
  #     assert_equal result_path, current_path
  #     assert page.has_content? "Sorry, the FDA has not provided ingredients for this drug :("
  #
  #     click_button "Try another search"
  #
  #     assert_equal root_path, current_path
  #   end
  # end

  test "user sees not found notice when they search for a drug that's not in the database" do
    VCR.use_cassette("drug-search-not-found") do
      visit root_path

      fill_in "drug", with: "synthroid"
      click_button "Search"

      assert_equal result_path, current_path
      assert page.has_content? "Sorry, we couldn't find the drug you searched for."

      click_button "Try another search"

      assert_equal root_path, current_path
    end
  end

  test "user sees not found notice when they search for a drug that doesn't return an rxcui" do
    VCR.use_cassette("drug-search-with-no-rxcui") do
      visit root_path

      fill_in "drug", with: "t"
      click_button "Search"

      assert_equal result_path, current_path
      assert page.has_content? "Sorry, we couldn't find the drug you searched for."

      click_button "Try another search"

      assert_equal root_path, current_path
    end
  end
end
