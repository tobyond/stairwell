require "stairwell/types/base_type"

module Stairwell::Types
  class FloatType < BaseType
    def valid?
      value.is_a?(Float)
    end

    def quote
      value
    end
  end
end
