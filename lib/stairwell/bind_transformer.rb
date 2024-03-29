# frozen_string_literal: true

module Stairwell
  class BindTransformer
    attr_reader :sql, :bind_hash, :depleting_bind_hash, :converted_sql

    def initialize(sql, bind_hash)
      @sql = sql
      @bind_hash = bind_hash
      @depleting_bind_hash = bind_hash.dup
    end

    # taking the sql string like "SELECT * WHERE name = :name AND id = :id"
    # and confirming that the bind_hash has all the named binds like
    # { name: "First", id: 22 }
    # if the sql string or the bind_hash have incorrect or extra values
    # and error will raise
    # The sql string will then have the appropropriate values substituted
    # with quoted values to ensure safety.
    def run
      convert_sql
      validate_bind_hash
      converted_sql
    end

    private

    def convert_sql
      @converted_sql = sql.gsub(/(:?):([a-zA-Z]\w*)/) do |_|
        replace = ::Regexp.last_match(2).to_sym
        validate_sql(replace)
        bind_hash[replace].quote
      end
    end

    def validate_sql(attr)
      raise SqlBindMismatch, ":#{attr} in your query is missing from your args" unless bind_hash[attr]

      depleting_bind_hash.delete(attr)
    end

    def validate_bind_hash
      return if depleting_bind_hash.empty?

      raise SqlBindMismatch,
            ":#{depleting_bind_hash.keys.join(', ')} in your bind hash is missing from your query: #{sql}"
    end
  end
end
