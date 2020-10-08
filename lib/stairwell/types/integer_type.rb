require "stairwell/types/base_type"

module Stairwell::Types
  class IntegerType < BaseType
    def valid?
      value.is_a?(Integer)
    end
  end
end
