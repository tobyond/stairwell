# frozen_string_literal: true

module Stairwell
  module Types
    class ColumnNameType < BaseType
      def valid?
        value.is_a?(String)
      end

      def quote
        connection.quote_column_name(value)
      end
    end
  end
end
