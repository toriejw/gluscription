require "test_helper"

class RxNormServiceTest < ActiveSupport::TestCase

  test "it can find drug name from rxcui" do
    actual_drug_name = RxNormService.find_drug_name("701961")

    assert_equal "Camphor 62 MG/ML Inhalant Solution", actual_drug_name
  end

end
