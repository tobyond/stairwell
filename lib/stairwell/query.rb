# frozen_string_literal: true

module Stairwell
  class Query
    class << self
      def validate_type(*args)
        @all_validations ||= {}
        @all_validations.merge!(Hash[*args])
      end

      def sql(**args)
        set_sql_string_from_file
        raise InvalidBindCount, 'Incorrect amount of args passed' if args.keys.sort != all_validations.keys.sort

        @type_hash = args.each_with_object({}) do |(name, value), hash|
          hash[name] = TypeObjectAssigner.run(name:, value:, all_validations:)
        end
        transformer.run
      end

      def query(string)
        @sql_string ||= string.squish
      end

      private

      attr_reader :type_hash, :all_validations, :sql_string

      def transformer
        BindTransformer.new(sql_string, type_hash)
      end

      def set_sql_string_from_file
        return unless Stairwell.configuration.path && File.exist?(associated_sql_file)

        file = File.read(associated_sql_file)
        @sql_string = file&.squish
      end

      def associated_sql_file
        "#{Stairwell.configuration.path}#{camelized_class}.sql"
      end

      def camelized_class
        self.to_s.gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
          .gsub(/([a-z\d])([A-Z])/,'\1_\2')
          .tr("-", "_")
          .downcase
      end
    end
  end
end
