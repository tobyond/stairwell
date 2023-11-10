# frozen_string_literal: true

require 'test_helper'

module Stairwell
  module Types
    class DateTypeTest < Minitest::Test
      def test_valid_when_valid
        string_type = Stairwell::Types::DateType.new('date')

        assert_equal string_type.valid?, true
      end

      def test_valid_when_not_valid
        assert_raises_with_message Stairwell::InvalidBindType, '1 is not date' do
          Stairwell::Types::DateType.new(1)
        end
      end

      def test_quote
        string_type = Stairwell::Types::DateType.new('date')

        assert_equal "'date'", string_type.quote
      end
    end
  end
end
