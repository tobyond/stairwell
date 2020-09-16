require "test_helper"

class StairwellTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Stairwell::VERSION
  end
end
