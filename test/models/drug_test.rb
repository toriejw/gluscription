require 'test_helper'

class DrugTest < ActiveSupport::TestCase

  test "it can find its name from search terms" do
    VCR.use_cassette("drug#name") do
      drug = Drug.new("b")

      assert_equal "Camphor 62 MG/ML Inhalant Solution", drug.name
    end
  end

  test "it can return its rxcui code" do
    VCR.use_cassette("drug#rxcui") do
      drug = Drug.new("b")

      assert_equal "701961", drug.rxcui
    end
  end

  test "it knows whether or not it's gluten free" do
    VCR.use_cassette("drug#gluten_free?") do
      tylenol = Drug.new("tylenol")
      warfarin = Drug.new("warfarin")
      drug_with_gluten = Drug.new("dextrin")

      assert tylenol.gluten_free?
      assert warfarin.gluten_free?
      
      refute drug_with_gluten.gluten_free?
    end
  end

end
