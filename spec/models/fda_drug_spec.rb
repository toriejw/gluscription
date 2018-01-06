require "rails_helper"

RSpec.describe FDADrug, type: :model do

  let(:rxcui) { "701961" }
  let(:mocked_fda_data) {
    {
      "results" => [
        {
          "openfda" => { "rxcui" => [ rxcui ] },
           "inactive_ingredient" => inactive_ingredients,
           "active_ingredient" => active_ingredients
         }
      ]
    }
  }
  let(:med_name) { "Camphor 62 MG/ML Inhalant Solution" }
  let(:inactive_ingredients) { [ "cats" ] }
  let(:active_ingredients) { [ "dogs" ] }

  before do
    allow(OpenFDAService).
      to receive(:return_raw_data).
      and_return(mocked_fda_data)

    allow(RxNormService).
      to receive(:find_drug_name).
      and_return(med_name)
  end

  it "can find its name from search terms" do
    med = FDADrug.new("b")

    expect(med.name).to eq(med_name)
  end

  it "can return its rxcui code" do
    med = FDADrug.new("b")

    expect(med.rxcui).to eq("701961")
  end

  it "can return a list of ingredients" do
    med                  = FDADrug.new("c")
    actual_ingredients   = med.full_ingredient_list
    expected_ingredients = "cats dogs"

    expect(expected_ingredients).to eq(actual_ingredients)
  end

  describe ".gluten_free?" do
    context "ingredient list is available" do
      context "med is gluten free" do
        let(:inactive_ingredients) { [ "inactive ingredients basil parsley coffee" ] }
        let(:active_ingredients) { [ "active ingredients fish oil" ] }

        it "returns yes" do
          warfarin = FDADrug.new("warfarin")

          expect(warfarin.gluten_free?).to eq(:yes)
        end
      end

      context "med is not gluten free" do
        let(:inactive_ingredients) { [ "basil malt parsley" ] }
        let(:active_ingredients) { [ "fish oil" ] }

        it "returns no" do
          rye = FDADrug.new("rye")

          expect(rye.gluten_free?).to eq(:no)
        end
      end

      context "med is maybe gluten free" do
        let(:inactive_ingredients) { [ "basil starch parsley" ] }
        let(:active_ingredients) { [ "fish oil" ] }

        it "returns maybe" do
          tylenol = FDADrug.new("tylenol")

          expect(tylenol.gluten_free?).to eq(:maybe)
        end
      end
    end

    context "ingredient list is unavailable" do
      let(:inactive_ingredients) { nil }
      let(:active_ingredients) { nil }

      it "returns 'ingredients_not_listed'" do
        med_without_ingredients = FDADrug.new("ra")

        expect(med_without_ingredients.gluten_free?).to eq(:ingredients_not_listed)
      end
    end
  end

end
