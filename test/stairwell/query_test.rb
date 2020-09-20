require "test_helper"

class SomeSql < Stairwell::Query
  validate_type :this, :string
  validate_type :that, :integer
  validate_type :the_other, :boolean
  validate_type :other_the, :float
  validate_type :other_that, :sql_date
  validate_type :other_this, :sql_date_time

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
  validate_type :boo, :sql_date_time

  query <<-SQL
    SELECT
      *
    FROM myothertable
    WHERE column_a = :foo
      AND column_b < :boo
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

    assert_raises_with_message Stairwell::InvalidBindType, "this is not string" do
      SomeSql.sql(**args_hash_dup)
    end
  end

  def test_incorrect_integer
    args_hash_dup = args_hash.dup
    args_hash_dup[:that] = "string"

    assert_raises_with_message Stairwell::InvalidBindType, "that is not integer" do
      SomeSql.sql(**args_hash_dup)
    end
  end

  def test_incorrect_boolean
    args_hash_dup = args_hash.dup
    args_hash_dup[:the_other] = "not_true"

    assert_raises_with_message Stairwell::InvalidBindType, "the_other is not boolean" do
      SomeSql.sql(**args_hash_dup)
    end
  end

  def test_incorrect_float
    args_hash_dup = args_hash.dup
    args_hash_dup[:other_the] = 1

    assert_raises_with_message Stairwell::InvalidBindType, "other_the is not float" do
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
    expected_result = "SELECT * FROM mytable WHERE column_a = 'string' AND column_b = 1 AND column_c = TRUE AND column_c = 1.0 AND column_c = 'Date' AND column_c = 'DateTime'"

    assert_match SomeSql.sql(**args_hash), expected_result
  end
end
