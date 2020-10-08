require "stairwell/types/base_type"

module Stairwell::Types
  class NullType < BaseType
    def valid?
      value.is_a?(NilClass)
    end
  end
end
