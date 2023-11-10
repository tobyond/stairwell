# frozen_string_literal: true

module Stairwell
  module Types
    class FloatType < BaseType
      def valid?
        value.is_a?(Float)
      end
    end
  end
end
