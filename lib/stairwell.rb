# frozen_string_literal: true

require 'active_record'

module Stairwell
  class Error < StandardError; end
  class InvalidBindType < StandardError; end
  class InvalidBindCount < StandardError; end
  class SqlBindMismatch < StandardError; end

  TYPE_CLASSES = {
    string: 'Stairwell::Types::StringType',
    integer: 'Stairwell::Types::IntegerType',
    boolean: 'Stairwell::Types::BooleanType',
    float: 'Stairwell::Types::FloatType',
    date: 'Stairwell::Types::DateType',
    date_time: 'Stairwell::Types::DateTimeType',
    null: 'Stairwell::Types::NullType',
    column_name: 'Stairwell::Types::ColumnNameType',
    table_name: 'Stairwell::Types::TableNameType'
  }.freeze

  # for development and testing
  unless defined?(Rails)
    ::ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'test.db'
    )
  end
end

require 'date'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/kamal/sshkit_with_ext.rb")
loader.setup
loader.eager_load # We need all commands loaded.
