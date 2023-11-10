# frozen_string_literal: true

module Stairwell
  module Types
    class StringType < BaseType
      def valid?
        value.is_a?(String)
      end
    end
  end
end
