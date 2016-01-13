require "test_helper"

class OpenFDAServiceTest < ActiveSupport::TestCase

  test "it can retrieve raw data from the openFDA API for a given drug search" do
    VCR.use_cassette("OpenFDAService#return_raw_data") do
      data = OpenFDAService.return_raw_data("tylenol")

      assert_equal Hash, data.class
      assert data["meta"]
      assert_equal ["Purposes Analgesic, Antipyretic"], data["results"][0]["purpose"]
      assert_equal ["Active Ingredient (in each capsule) Acetaminophen 500 mg"], data["results"][0]["active_ingredient"]
    end
  end

end
