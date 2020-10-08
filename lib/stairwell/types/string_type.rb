require "stairwell/types/base_type"

module Stairwell::Types
  class StringType < BaseType
    def valid?
      value.is_a?(String)
    end
  end
end
