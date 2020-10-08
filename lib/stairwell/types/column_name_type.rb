require "stairwell/types/base_type"

module Stairwell::Types
  class ColumnNameType < BaseType
    def valid?
      value.is_a?(String)
    end

    def quote
      connection.quote_column_name(value)
    end
  end
end
