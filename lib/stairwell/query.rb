module Stairwell
  class Query

    class << self
      attr_accessor :bind_hash, :all_validations, :sql_string

      def validate_type(*args)
        @all_validations ||= {}
        @all_validations.merge!(Hash[*args])
      end

      def sql(**args)
        @bind_hash = args
        validate!
        transformed_sql_string
      end

      def query(string)
        @sql_string = string
      end

      private

        def validate!
          raise InvalidBindCount.new("Incorrect amount of args passed") unless correct_args?

          bind_hash.each do |bind_name, bind_value|
            type = all_validations[bind_name]
            type = type.first if type.is_a?(Array)
            valid = TypeValidator.send(type, bind_value)

            raise InvalidBindType.new("#{bind_name} is not #{all_validations[bind_name]}") unless valid
          end
        end

        def transformed_sql_string
          BindTransformer.new(sql_string.squish!, bind_hash).transform
        end

        def correct_args?
          bind_hash.keys.sort == all_validations.keys.sort
        end
    end
  end
end
