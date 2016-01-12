require 'test_helper'

class DrugTest < ActiveSupport::TestCase
  test "it can find its name from search terms" do
    VCR.use_cassette("drug#name") do
      drug = Drug.new("b")

      assert_equal "Camphor 62 MG/ML Inhalant Solution", drug.name
    end
  end
end
