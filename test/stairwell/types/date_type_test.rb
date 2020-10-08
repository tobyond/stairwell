require "test_helper"

class Stairwell::Types::DateTypeTest < Minitest::Test

  def test_valid_when_valid
    string_type = Stairwell::Types::DateType.new("date")

    assert_equal string_type.valid?, true
  end

  def test_valid_when_not_valid
    string_type = Stairwell::Types::DateType.new(1)

    assert_equal string_type.valid?, false
  end

  def test_quote
    string_type = Stairwell::Types::DateType.new("date")

    assert_equal "'date'", string_type.quote
  end
end
