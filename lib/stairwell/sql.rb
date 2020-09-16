module Stairwell
  class Sql
    extend Forwardable

    class << self
      attr_accessor :binds, :all_validations, :sql_string

      def validate_bind(*args)
        @all_validations ||= {}
        @all_validations.merge!(Hash[*args])
      end

      def sql
        sql_string.squish!
      end

      def query(string)
        @sql_string = string
      end
    end

    def initialize(**args)
      self.class.binds = args
      validate!
    end

    def_delegator :'self.class', :sql
    def_delegator :'self.class', :binds
    def_delegator :'self.class', :all_validations

    private

      def validate!
        raise Stairwell::InvalidBind.new("Incorrect amount of args passed") unless correct_args?

        self.class.binds.each do |bind_name, bind_value|
          valid = bind_value.is_a?(self.class.all_validations[bind_name])

          raise Stairwell::InvalidBind.new("#{bind_name} is not #{self.class.all_validations[bind_name]}") unless valid
        end
      end

      def correct_args?
        binds.keys.sort == all_validations.keys.sort
      end
  end
end
