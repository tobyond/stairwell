require "test_helper"

class Stairwell::Types::StringTypeTest < Minitest::Test

  def test_valid_when_valid
    string_type = Stairwell::Types::StringType.new("string")

    assert_equal string_type.valid?, true
  end

  def test_valid_when_not_valid
    string_type = Stairwell::Types::StringType.new(1)

    assert_equal string_type.valid?, false
  end

  def test_quote
    string_type = Stairwell::Types::StringType.new("string's")

    assert_equal "'string''s'", string_type.quote
  end
end
