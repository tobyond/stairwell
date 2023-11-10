# frozen_string_literal: true

module Stairwell
  module Types
    class BooleanType < BaseType
      def valid?
        value.is_a?(TrueClass) || value.is_a?(FalseClass)
      end
    end
  end
end
