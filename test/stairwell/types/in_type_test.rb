# frozen_string_literal: true

require 'test_helper'

module Stairwell
  module Types
    class InTypeTest < Minitest::Test
      def test_valid_when_valid
        string_type = Stairwell::Types::InType.new([1, 2], :integer)

        assert_equal string_type.valid?, true
      end

      def test_valid_when_not_valid_missing_array
        string_type = Stairwell::Types::InType.new('42', :string)

        assert_equal string_type.valid?, false
      end

      def test_valid_when_invalid_contents
        string_type = Stairwell::Types::InType.new([1, 2], :string)

        assert_raises_with_message Stairwell::InvalidBindType, '1 is not string' do
          string_type.valid?
        end
      end

      def test_quote
        string_type = Stairwell::Types::InType.new(["this's", "string's"], :string)

        assert_equal "'this''s', 'string''s'", string_type.quote
      end
    end
  end
end
