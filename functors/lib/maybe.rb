class Maybe
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def fmap(function)
  end

  def ==(other)
    other.value == @value
  end
end
