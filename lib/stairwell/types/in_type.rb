require "stairwell/types/base_type"

module Stairwell::Types
  class InType
    attr_reader :value, :type

    def initialize(value, type)
      @value = value
      @type = type
    end

    def valid?
      value.is_a?(Array) && contained_values.all?(&:valid?)
    end

    def quote
      contained_values.map(&:quote).join(", ")
    end

    private

      def contained_values
        value.map do |contained|
          Stairwell::TYPE_CLASSES[type].new(contained)
        end
      end
  end
end
