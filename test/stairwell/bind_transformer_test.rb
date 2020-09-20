require "test_helper"

class Stairwell::BindTransformerTest < Minitest::Test
  def test_incorrect_sql_args
    sql = "SELECT * FROM table_1 WHERE name = :name AND age = :age"
    binds = { name: "First" }

    assert_raises_with_message Stairwell::SqlBindMismatch, ":age in your query is missing from your bind hash: {:name=>\"First\"}" do
      Stairwell::BindTransformer.new(sql, binds).transform
    end
  end

  def test_incorrect_bind_hash_args
    sql = "SELECT * FROM table_1 WHERE name = :name"
    binds = { name: "First", age: 99 }

    assert_raises_with_message Stairwell::SqlBindMismatch, "{:age=>99} in your bind hash is missing from your query: #{sql}"  do
      Stairwell::BindTransformer.new(sql, binds).transform
    end
  end

  def test_quoting_for_all_types
    sql = <<-SQL.squish!
      SELECT
        *
      FROM
        table_1
      WHERE
        name = :name
        age = :age
        active = :active
        date_joined = :date_joined
        created_at = :created_at
        gpa = :gpa;
    SQL
    binds = {
      name: "First",
      age: 99,
      active: true,
      date_joined: "2008-08-28",
      created_at: "2008-08-28 23:41:18",
      gpa: 4.2
    }
    expected_result = "SELECT * FROM table_1 WHERE name = 'First' age = 99 active = TRUE date_joined = '2008-08-28' created_at = '2008-08-28 23:41:18' gpa = 4.2;"

    assert_match Stairwell::BindTransformer.new(sql, binds).transform, expected_result
  end
end
