# frozen_string_literal: true

require 'test_helper'

module Stairwell
  module Types
    class TableNameTypeTest < Minitest::Test
      def test_valid_when_valid
        string_type = Stairwell::Types::TableNameType.new('table_name')

        assert_equal string_type.valid?, true
      end

      def test_valid_when_not_valid
        assert_raises_with_message Stairwell::InvalidBindType, '1 is not tablename' do
          Stairwell::Types::TableNameType.new(1)
        end
      end

      def test_quote
        string_type = Stairwell::Types::TableNameType.new('table_name')

        assert_equal '"table_name"', string_type.quote
      end
    end
  end
end
