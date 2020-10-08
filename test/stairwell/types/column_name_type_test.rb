require "test_helper"

class Stairwell::Types::ColumnNameTypeTest < Minitest::Test

  def test_valid_when_valid
    string_type = Stairwell::Types::ColumnNameType.new("column_name")

    assert_equal string_type.valid?, true
  end

  def test_valid_when_not_valid
    string_type = Stairwell::Types::ColumnNameType.new(1)

    assert_equal string_type.valid?, false
  end

  def test_quote
    string_type = Stairwell::Types::ColumnNameType.new("column_name")

    assert_equal "\"column_name\"", string_type.quote
  end
end
