class Appendable
  def mappend(other)
    raise NotImplementedError
  end
end

class Number < Appendable
  def initiialize(value)
    @value = value
  end

  attr_reader :value

  def add(other)
    return other if @value == 0
    return self if other.value == 0
    self.class.new(@value + other.value)
  end

  def ==(other)
    other.value == value
  end
end
