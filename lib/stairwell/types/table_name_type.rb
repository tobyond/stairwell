# frozen_string_literal: true

module Stairwell
  module Types
    class TableNameType < BaseType
      def valid?
        value.is_a?(String)
      end

      def quote
        connection.quote_table_name(value)
      end
    end
  end
end
