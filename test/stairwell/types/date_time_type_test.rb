# frozen_string_literal: true

require 'test_helper'

module Stairwell
  module Types
    class DateTimeTypeTest < Minitest::Test
      def test_valid_when_valid
        string_type = Stairwell::Types::DateTimeType.new('date_time')

        assert_equal string_type.valid?, true
      end

      def test_valid_when_not_valid
        assert_raises_with_message Stairwell::InvalidBindType, '1 is not datetime' do
          Stairwell::Types::DateTimeType.new(1)
        end
      end

      def test_quote
        string_type = Stairwell::Types::DateTimeType.new('date_time')

        assert_equal "'date_time'", string_type.quote
      end
    end
  end
end
