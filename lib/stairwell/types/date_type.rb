require "stairwell/types/base_type"

module Stairwell::Types
  class DateType < BaseType
    def valid?
      value.is_a?(String)
    end

    def quote
      "'#{value.gsub('\\', '\&\&').gsub("'", "''")}'"
    end
  end
end
