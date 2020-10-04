require "date"
require "stairwell/bind_transformer"
require "stairwell/query"
require "stairwell/version"
require "stairwell/core_extensions/core"
require "stairwell/types/boolean_type"
require "stairwell/types/date_time_type"
require "stairwell/types/date_type"
require "stairwell/types/float_type"
require "stairwell/types/integer_type"
require "stairwell/types/in_type"
require "stairwell/types/string_type"
require "stairwell/types/null_type"

module Stairwell
  class Error < StandardError; end
  class InvalidBindType < StandardError; end
  class InvalidBindCount < StandardError; end
  class SqlBindMismatch < StandardError; end

  TYPE_CLASSES = {
    string: Stairwell::Types::StringType,
    integer: Stairwell::Types::IntegerType,
    boolean: Stairwell::Types::BooleanType,
    float: Stairwell::Types::FloatType,
    date: Stairwell::Types::DateType,
    date_time: Stairwell::Types::DateTimeType,
    null: Stairwell::Types::NullType
  }.freeze

  module Boolean; end
  class TrueClass; include Boolean; end
  class FalseClass; include Boolean; end

  module SqlDate; end
  module SqlDateTime; end
  class String; include SqlDate; include SqlDateTime; end
end
