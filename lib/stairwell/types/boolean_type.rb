require "stairwell/types/base_type"

module Stairwell::Types
  class BooleanType < BaseType
    def initialize(value)
      @value = cast_value(value)
    end

    def valid?
      value.is_a?(TrueClass) || value.is_a?(FalseClass)
    end

    def quote
      value.sql_quote
    end

    private

      def cast_value(value)
        return true if ['true', 1, '1', true].include?(value)
        return false if ['false', 0, '0', false].include?(value)

        raise Stairwell::InvalidBindType.new("#{value} is not boolean")
      end
  end
end
