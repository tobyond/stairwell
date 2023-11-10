# frozen_string_literal: true

module Stairwell
  class Query
    class << self
      def validate_type(*args)
        @all_validations ||= {}
        @all_validations.merge!(Hash[*args])
      end

      def sql(**args)
        raise InvalidBindCount, 'Incorrect amount of args passed' if args.keys.sort != all_validations.keys.sort

        @type_hash = args.each_with_object({}) do |(name, value), hash|
          hash[name] = TypeObjectAssigner.run(name:, value:, all_validations:)
        end
        transformer.run
      end

      def query(string)
        @sql_string = string.squish
      end

      private

      attr_reader :type_hash, :all_validations, :sql_string

      def transformer
        BindTransformer.new(sql_string, type_hash)
      end
    end
  end
end
