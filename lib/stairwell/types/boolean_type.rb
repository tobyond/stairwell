require "stairwell/types/base_type"

module Stairwell::Types
  class BooleanType < BaseType
    def valid?
      value.is_a?(TrueClass) || value.is_a?(FalseClass)
    end
  end
end
