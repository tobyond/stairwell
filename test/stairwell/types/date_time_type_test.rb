require "test_helper"

class Stairwell::Types::DateTimeTypeTest < Minitest::Test

  def test_valid_when_valid
    string_type = Stairwell::Types::DateTimeType.new("date_time")

    assert_equal string_type.valid?, true
  end

  def test_valid_when_not_valid
    string_type = Stairwell::Types::DateTimeType.new(1)

    assert_equal string_type.valid?, false
  end

  def test_quote
    string_type = Stairwell::Types::DateTimeType.new("date_time")

    assert_equal "'date_time'", string_type.quote
  end
end
