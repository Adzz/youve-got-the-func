class Number
  def initialize(value)
    @value = value
  end

  attr_reader :value

  def multiply(other)
    return other if @value == 1
    return self if other.value == 1
    Number.new(@value * other.value)
  end

  def ==(other)
    other.value == value
  end
end
