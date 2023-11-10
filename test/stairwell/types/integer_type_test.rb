# frozen_string_literal: true

require 'test_helper'

module Stairwell
  module Types
    class IntegerTypeTest < Minitest::Test
      def test_valid_when_valid
        string_type = Stairwell::Types::IntegerType.new(1)

        assert_equal string_type.valid?, true
      end

      def test_valid_when_not_valid
        assert_raises_with_message Stairwell::InvalidBindType, '1 is not integer' do
          Stairwell::Types::IntegerType.new('1')
        end
      end

      def test_quote
        string_type = Stairwell::Types::IntegerType.new(1)

        assert_equal '1', string_type.quote
      end
    end
  end
end
