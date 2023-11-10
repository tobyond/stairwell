# frozen_string_literal: true

module Stairwell
  module Types
    class BaseType
      attr_reader :value

      def initialize(value)
        @value = value
        validate!
      end

      def quote
        connection.quote(value)
      end

      def connection
        @connection ||= ActiveRecord::Base.connection
      end

      def validate!
        return if valid?

        raise InvalidBindType, "#{value} is not #{type_name}"
      end

      def type_name
        self.class.name.split('::').last.gsub('Type', '').downcase
      end
    end
  end
end
