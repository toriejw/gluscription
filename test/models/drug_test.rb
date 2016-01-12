require 'test_helper'

class DrugTest < ActiveSupport::TestCase
  test "it can find its name from search terms" do
    drug = Drug.new("b")

    assert_equal "Bee Venom", drug.name
  end
end
