# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'stairwell'
require 'active_record'

require 'minitest/autorun'

module Minitest
  class Test
    def assert_raises_with_message(exception, msg, &block)
      block.call
    rescue exception => e
      assert_match msg, e.message
    else
      raise "Expected to raise #{exception} w/ message #{msg}, none raised"
    end

    def assert_nothing_raised(_exception, &block)
      block.call
    end
  end
end
