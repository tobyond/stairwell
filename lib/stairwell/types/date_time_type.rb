require "stairwell/types/base_type"

module Stairwell::Types
  class DateTimeType < BaseType
    def valid?
      value.is_a?(String)
    end
  end
end
