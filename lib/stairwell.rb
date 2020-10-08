require "active_record"
require "date"
require "stairwell/query"
require "stairwell/version"

module Stairwell
  class Error < StandardError; end
  class InvalidBindType < StandardError; end
  class InvalidBindCount < StandardError; end
  class SqlBindMismatch < StandardError; end

  TYPE_CLASSES = {
    string: "Stairwell::Types::StringType",
    integer: "Stairwell::Types::IntegerType",
    boolean: "Stairwell::Types::BooleanType",
    float: "Stairwell::Types::FloatType",
    date: "Stairwell::Types::DateType",
    date_time: "Stairwell::Types::DateTimeType",
    null: "Stairwell::Types::NullType",
    column_name: "Stairwell::Types::ColumnNameType",
    table_name: "Stairwell::Types::TableNameType"
  }.freeze

  # for development and testing
  unless defined?(Rails)
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'test.db'
    )
  end
end
