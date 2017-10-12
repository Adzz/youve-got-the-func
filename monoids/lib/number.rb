class Number
  def initialize(value)
    @value = value
  end

  attr_reader :value

  def multiply(other)
  end

  def ==(other)
    other.value == value
  end
end
