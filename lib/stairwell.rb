require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup
require "forwardable"

module Stairwell
  class Error < StandardError; end
  class InvalidBind < StandardError; end
end

module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end

class String
  def squish!
    gsub!(/[[:space:]]+/, " ")
    strip!
    self
  end
end
