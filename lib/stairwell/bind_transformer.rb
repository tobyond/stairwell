module Stairwell
  class BindTransformer

    attr_accessor :sql, :bind_hash, :depleting_bind_hash

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
    # Note: $2 is The match for the first, second, etc. parenthesized groups in the last regex
    def transform
      converted_sql = sql.gsub(/(:?):([a-zA-Z]\w*)/) do |_|
        replace = $2.to_sym
        validate_sql(replace)
        bind_hash[replace].sql_quote
      end

      validate_bind_hash
      converted_sql
    end

    private

      def validate_sql(attr)
        raise SqlBindMismatch, ":#{attr} in your query is missing from your bind hash: #{bind_hash}" unless bind_hash[attr]

        depleting_bind_hash.delete(attr)
      end

      def validate_bind_hash
        raise SqlBindMismatch, "#{depleting_bind_hash} in your bind hash is missing from your query: #{sql}" unless depleting_bind_hash.empty?
      end

  end
end
