require "test_helper"

class Stairwell::Types::FloatTypeTest < Minitest::Test

  def test_valid_when_valid
    string_type = Stairwell::Types::FloatType.new(4.2)

    assert_equal string_type.valid?, true
  end

  def test_valid_when_not_valid
    string_type = Stairwell::Types::FloatType.new("42")

    assert_equal string_type.valid?, false
  end

  def test_quote
    string_type = Stairwell::Types::FloatType.new(4.2)

    assert_equal "4.2", string_type.quote
  end
end
