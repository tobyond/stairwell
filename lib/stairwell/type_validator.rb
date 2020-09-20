require "stairwell/core_extensions/core"
require "stairwell/core_extensions/types"

module Stairwell
  class TypeValidator

    class << self
      TYPES = [
        String,
        Boolean,
        Integer,
        Float,
        SqlDate,
        SqlDateTime
      ].freeze

      TYPES.each do |type|
        define_method(type.to_s.underscore.to_sym) do |arg|
          arg.is_a?(type)
        end
      end
    end
  end
end
