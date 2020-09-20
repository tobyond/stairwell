require "date"
require "zeitwerk"
require "ostruct"
loader = Zeitwerk::Loader.for_gem
loader.setup

module Stairwell
  class Error < StandardError; end
  class InvalidBindType < StandardError; end
  class InvalidBindCount < StandardError; end
  class SqlBindMismatch < StandardError; end
end

loader.eager_load
