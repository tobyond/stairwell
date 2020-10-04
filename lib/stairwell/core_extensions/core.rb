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
