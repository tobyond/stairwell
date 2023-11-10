# frozen_string_literal: true

module Stairwell
  module Types
    class NullType < BaseType
      def valid?
        value.is_a?(NilClass)
      end
    end
  end
end
