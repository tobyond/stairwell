require "test_helper"

class Stairwell::Types::BooleanTypeTest < Minitest::Test

  def test_valid_when_valid_with_true
    string_type = Stairwell::Types::BooleanType.new(true)

    assert_equal true, string_type.valid?
  end

  def test_valid_when_valid_with_false
    string_type = Stairwell::Types::BooleanType.new(false)

    assert_equal true, string_type.valid?
  end

  def test_valid_when_not_valid
    string_type = Stairwell::Types::BooleanType.new(1)

    assert_equal false, string_type.valid?
  end

  def test_quote_when_true
    string_type = Stairwell::Types::BooleanType.new(true)

    assert_equal "1", string_type.quote
  end

  def test_quote_when_false
    string_type = Stairwell::Types::BooleanType.new(false)

    assert_equal "0", string_type.quote
  end
end
