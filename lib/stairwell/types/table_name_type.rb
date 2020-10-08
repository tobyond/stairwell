require "stairwell/types/base_type"

module Stairwell::Types
  class TableNameType < BaseType
    def valid?
      value.is_a?(String)
    end

    def quote
      connection.quote_table_name(value)
    end
  end
end
