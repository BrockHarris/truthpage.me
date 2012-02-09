#added these simple methods to the boolean classes for use in views etc.
class TrueClass
  def to_yn
    "Yes"
  end
end

class FalseClass
  def to_yn
    "No"
  end
end

class NilClass
  def to_yn
    "No"
  end
end