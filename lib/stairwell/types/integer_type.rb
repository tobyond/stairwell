# frozen_string_literal: true

module Stairwell
  module Types
    class IntegerType < BaseType
      def valid?
        value.is_a?(Integer)
      end
    end
  end
end
