require "stairwell/types/base_type"

module Stairwell::Types
  class IntegerType < BaseType
    def valid?
      value.is_a?(Integer)
    end

    def quote
      value
    end
  end
end
