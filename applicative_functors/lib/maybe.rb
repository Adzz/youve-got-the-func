class Maybe
  def initialize(value)
    @value = value
  end

  def fmap(function)
    return self if value.nil?
    return Maybe.new(compose(value, function)) if value.is_a?(Proc) && function.is_a?(Proc)
    Maybe.new(function.curry.call(value))
  end

  def ==(other)
    other.value == self.value
  end

  attr_reader :value

  private

  def compose(f, g)
    lambda { |*args| f.call(*g.call(*args)) }
  end
end
