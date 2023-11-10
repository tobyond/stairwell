require "test_helper"

class SomeSql < Stairwell::Query
  validate_type :this, :string
  validate_type :that, :integer
  validate_type :the_other, :boolean
  validate_type :other_the, :float
  validate_type :other_that, :date
  validate_type :other_this, :date_time

  query <<-SQL
    SELECT
      *
    FROM mytable
    WHERE column_a = :this
      AND column_b = :that
      AND column_c = :the_other
      AND column_c = :other_the
      AND column_c = :other_that
      AND column_c = :other_this
  SQL
end

class SomeOtherSql < Stairwell::Query
  validate_type :foo, :string
  validate_type :moo, [:integer]
  validate_type :goo, [:string]

  query <<-SQL
    SELECT
      *
    FROM myothertable
    WHERE column_a = :foo
      AND column_b IN(:moo)
      AND column_c IN(:goo)
  SQL
end

class Stairwell::QueryTest < Minitest::Test
  def args_hash
    { this: "string", that: 1, the_other: true, other_the: 1.0, other_that: "Date", other_this: "DateTime" }
  end

  def test_missing_validate_bind
    assert_raises_with_message Stairwell::InvalidBindCount, "Incorrect amount of args passed" do
      SomeSql.sql(this: "string")
    end
  end

  def test_incorrect_string
    args_hash_dup = args_hash.dup
    args_hash_dup[:this] = 1

    assert_raises_with_message Stairwell::InvalidBindType, "1 is not string" do
      SomeSql.sql(**args_hash_dup)
    end
  end

  def test_incorrect_integer
    args_hash_dup = args_hash.dup
    args_hash_dup[:that] = "string"

    assert_raises_with_message Stairwell::InvalidBindType, "string is not integer" do
      SomeSql.sql(**args_hash_dup)
    end
  end

  def test_incorrect_boolean
    args_hash_dup = args_hash.dup
    args_hash_dup[:the_other] = "not_true"

    assert_raises_with_message Stairwell::InvalidBindType, "not_true is not boolean" do
      SomeSql.sql(**args_hash_dup)
    end
  end

  def test_incorrect_float
    args_hash_dup = args_hash.dup
    args_hash_dup[:other_the] = 1

    assert_raises_with_message Stairwell::InvalidBindType, "1 is not float" do
      SomeSql.sql(**args_hash_dup)
    end
  end

  def test_correct_args_with_boolean_true
    assert_nothing_raised Stairwell::InvalidBindType do
      SomeSql.sql(**args_hash)
    end

    assert_nothing_raised Stairwell::InvalidBindCount do
      SomeSql.sql(**args_hash)
    end
  end

  def test_correct_args_with_boolean_false
    args_hash_dup = args_hash.dup
    args_hash_dup[:the_other] = false

    assert_nothing_raised Stairwell::InvalidBindType do
      SomeSql.sql(**args_hash)
    end

    assert_nothing_raised Stairwell::InvalidBindCount do
      SomeSql.sql(**args_hash)
    end
  end

  def test_integration
    expected_result = "SELECT * FROM mytable WHERE column_a = 'string' AND column_b = 1 AND column_c = 1 AND column_c = 1.0 AND column_c = 'Date' AND column_c = 'DateTime'"

    assert_match SomeSql.sql(**args_hash), expected_result
  end

  def test_in_statement_with_arrays_with_valid_args
    binds = { foo: "This", moo: [1, 2, 3, 4], goo: %w(1 2 3 4) }
    expected_result = "SELECT * FROM myothertable WHERE column_a = 'This' AND column_b IN(1, 2, 3, 4) AND column_c IN('1', '2', '3', '4')"

    assert_match SomeOtherSql.sql(**binds), expected_result
  end

  def test_in_statement_with_arrays_with_invalid_args
    binds = { foo: "This", moo: [1, '2', 3, 4], goo: %w(1 2 3 4) }

    assert_raises_with_message Stairwell::InvalidBindType, "2 is not integer" do
      SomeOtherSql.sql(**binds)
    end

  end
end
