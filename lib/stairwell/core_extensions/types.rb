module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end

module SqlDate; end
module SqlDateTime; end
class String; include SqlDate; include SqlDateTime; end
