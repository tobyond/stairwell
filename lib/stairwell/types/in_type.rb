# frozen_string_literal: true

module Stairwell
  module Types
    class InType
      attr_reader :value, :type

      def initialize(value, type)
        @value = value
        @type = type
      end

      def quote
        contained_values.map(&:quote).join(', ')
      end

      def valid?
        value.is_a?(Array) && contained_values.all?(&:valid?)
      end

      private

      def contained_values
        value.map do |contained|
          Object.const_get(Stairwell::TYPE_CLASSES[type]).new(contained)
        end
      end
    end
  end
end
