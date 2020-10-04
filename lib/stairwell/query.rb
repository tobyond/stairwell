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
            if type.is_a?(Array)
              type = type.first
              type_object = Types::InType.new(bind_value, type)
            end
            type_object ||= TYPE_CLASSES[type].new(bind_value)

            raise InvalidBindType.new("#{bind_name} is not #{all_validations[bind_name]}") unless type_object.valid?

            bind_hash[bind_name] = type_object
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
