require "test_helper"

class SomeSql < Stairwell::Sql
  validate_bind :this, String
  validate_bind :that, Integer
  validate_bind :the_other, Boolean
  validate_bind :other_the, Float

  query <<-SQL
    SELECT
      *
    FROM mytable
    WHERE column_a = :this
      AND column_b = :that
      AND column_c = :the_other
  SQL
end

class SomeOtherSql < Stairwell::Sql
  validate_bind :foo, String
  validate_bind :boo, Integer

  query <<-SQL
    SELECT
      *
    FROM myothertable
    WHERE column_a = :foo
      AND column_b = :boo
  SQL
end

class Stairwell::SqlTest < Minitest::Test
  def test_missing_validate_bind
    assert_raises_with_message Stairwell::InvalidBind, "Incorrect amount of args passed" do
      SomeSql.new(this: "string")
    end
  end


  def test_incorrect_string
    assert_raises_with_message Stairwell::InvalidBind, "this is not String" do
      SomeSql.new(this: 2, that: 1, the_other: true, other_the: 1.0)
    end
  end

  def test_incorrect_integer
    assert_raises_with_message Stairwell::InvalidBind, "that is not Integer" do
      SomeSql.new(this: "string", that: "string", the_other: true, other_the: 1.0)
    end
  end

  def test_incorrect_boolean
    assert_raises_with_message Stairwell::InvalidBind, "the_other is not Boolean" do
      SomeSql.new(this: "string", that: 1, the_other: "not_true", other_the: 1.0)
    end
  end

  def test_incorrect_float
    assert_raises_with_message Stairwell::InvalidBind, "other_the is not Float" do
      SomeSql.new(this: "string", that: 1, the_other: false, other_the: 1)
    end
  end

  def test_correct_args_with_boolean_true
    assert_nothing_raised Stairwell::InvalidBind do
      SomeSql.new(this: "string", that: 1, the_other: true, other_the: 1.0)
    end
  end

  def test_correct_args_with_boolean_false
    assert_nothing_raised Stairwell::InvalidBind do
      SomeSql.new(this: "string", that: 1, the_other: false, other_the: 1.0)
    end
  end

  def test_sql_string_return
    expected_result = <<-SQL.squish!
      SELECT
        *
      FROM mytable
      WHERE column_a = :this
        AND column_b = :that
        AND column_c = :the_other
    SQL
    instance = SomeSql.new(this: "string", that: 1, the_other: false, other_the: 1.0)

    assert_match instance.sql, expected_result
  end

  def test_binds
    expected_result = { this: "string", that: 1, the_other: false, other_the: 1.0 }
    instance = SomeSql.new(**expected_result)

    assert_match instance.binds.to_s, expected_result.to_s
  end

  def test_two_classes_binds
    expected_result = { this: "string", that: 1, the_other: false, other_the: 1.0 }
    instance_1 = SomeSql.new(**expected_result)
    expected_result_2 = { foo: "string", boo: 1 }
    instance_2 = SomeOtherSql.new(**expected_result_2)

    assert_match instance_1.binds.to_s, expected_result.to_s
    assert_match instance_2.binds.to_s, expected_result_2.to_s
  end

  def test_two_classes_validating
    args_1 = { this: "string", that: 1, the_other: false, other_the: 1.0 }
    instance = SomeSql.new(**args_1)
    args_2 = { foo: "string", boo: "1" }

    assert_match instance.binds.to_s, args_1.to_s
    assert_raises_with_message Stairwell::InvalidBind, "boo is not Integer" do
      SomeOtherSql.new(**args_2)
    end
  end

  def test_two_classes_sql_string_return
    expected_result_1 = <<-SQL1.squish!
      SELECT
        *
      FROM mytable
      WHERE column_a = :this
        AND column_b = :that
        AND column_c = :the_other
    SQL1
    args_1 = { this: "string", that: 1, the_other: false, other_the: 1.0 }
    expected_result_2 = <<-SQL2.squish!
      SELECT
        *
      FROM myothertable
      WHERE column_a = :foo
        AND column_b = :boo
    SQL2
    args_2 = { foo: "string", boo: 1 }

    assert_match SomeSql.new(**args_1).sql, expected_result_1
    assert_match SomeOtherSql.new(**args_2).sql, expected_result_2
  end
end
