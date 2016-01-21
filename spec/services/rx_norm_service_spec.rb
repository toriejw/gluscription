require "rails_helper"

describe RxNormService do

  it "can find drug name from rxcui" do
    actual_drug_name = RxNormService.find_drug_name("701961")

    expect(actual_drug_name).to eq("Camphor 62 MG/ML Inhalant Solution")
  end

end
