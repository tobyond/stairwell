module Stairwell::Types
  class BaseType
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def quote
      connection.quote(value)
    end

    def connection
      @connection ||= ActiveRecord::Base.connection
    end
  end
end
