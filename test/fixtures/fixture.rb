# frozen_string_literal: true

class Fixture < Stairwell::Query
  validate_type :foo, :string
  validate_type :moo, [:integer]
  validate_type :goo, [:string]
end
