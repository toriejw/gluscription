require "rails_helper"

describe OpenFDAService do

  it "can retrieve raw data from the openFDA API for a given drug search" do
    data = OpenFDAService.return_raw_data("tylenol")

    expect(data.class).to eq(Hash)
    expect(data["results"][0]["purpose"]).to eq(["Purposes Analgesic, Antipyretic"])
    expect(data["results"][0]["active_ingredient"]).to eq(["Active Ingredient (in each capsule) Acetaminophen 500 mg"])
  end

end
