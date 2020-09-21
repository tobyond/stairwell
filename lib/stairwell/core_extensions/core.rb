class String
  def squish!
    gsub!(/[[:space:]]+/, " ")
    strip!
    self
  end

  def underscore
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end

  def sql_quote
    "'#{self.gsub('\\', '\&\&').gsub("'", "''")}'"
  end
end

class TrueClass
  def sql_quote
    "TRUE"
  end
end

class FalseClass
  def sql_quote
    "FALSE"
  end
end

class NilClass
  def sql_quote
    "IS NULL"
  end
end

class Integer
  def sql_quote
    self
  end
end

class Float
  def sql_quote
    self
  end
end

class Array
  def sql_quote
    map(&:sql_quote).join(", ")
  end
end

class Date
  def self.parsable?(string)
    begin
      parse(string)
      true
    rescue ArgumentError
      false
    end
  end
end

class DateTime
  def self.parsable?(string)
    begin
      parse(string)
      true
    rescue ArgumentError
      false
    end
  end
end
