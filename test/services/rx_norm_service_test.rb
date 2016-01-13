require "test_helper"
require_relative "../../app/services/rx_norm_service.rb"

class RXnormServiceTest < ActiveSupport::TestCase

  test "it can find drug name from rxcui" do
    VCR.use_cassette("RXnormService#find_drug_name") do
      actual_drug_name = RXnormService.find_drug_name("701961")

      assert_equal "Camphor 62 MG/ML Inhalant Solution", actual_drug_name
    end
  end

end
