require "stairwell/types/base_type"

module Stairwell::Types
  class NullType < BaseType
    def valid?
      value.is_a?(NilClass) || value.is_a?(String)
    end

    def quote
      value.nil? ? "IS NULL" : "IS NOT NULL"
    end
  end
end
