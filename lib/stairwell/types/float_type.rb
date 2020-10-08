require "stairwell/types/base_type"

module Stairwell::Types
  class FloatType < BaseType
    def valid?
      value.is_a?(Float)
    end
  end
end
