# frozen_string_literal: true

module Stairwell
  class TypeObjectAssigner
    attr_reader :name, :value, :all_validations

    def self.run(...)
      new(...).run
    end

    def initialize(name:, value:, all_validations:)
      @name = name
      @value = value
      @all_validations = all_validations
    end

    def run
      type_object
    end

    private

    def proposed_type
      all_validations[name]
    end

    def type_object
      if proposed_type.is_a?(Array)
        Types::InType.new(value, proposed_type.first)
      else
        Object.const_get(TYPE_CLASSES[proposed_type]).new(value)
      end
    end
  end
end
