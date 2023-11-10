# frozen_string_literal: true

require 'test_helper'

module Stairwell
  module Types
    class FloatTypeTest < Minitest::Test
      def test_valid_when_valid
        string_type = Stairwell::Types::FloatType.new(4.2)

        assert_equal string_type.valid?, true
      end

      def test_valid_when_not_valid
        assert_raises_with_message Stairwell::InvalidBindType, '42 is not float' do
          Stairwell::Types::FloatType.new('42')
        end
      end

      def test_quote
        string_type = Stairwell::Types::FloatType.new(4.2)

        assert_equal '4.2', string_type.quote
      end
    end
  end
end
