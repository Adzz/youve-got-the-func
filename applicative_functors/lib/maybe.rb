class Maybe
  def initialize(value)
    @value = value
  end

  def fmap(function)
    return self if value.nil?
    # this is obviously very nasty
    begin
      Maybe.new(function.curry.call(value))
    rescue NoMethodError
      Maybe.new(compose(value, function))
    end
  end

  def apply(maybe_function)
    return self if maybe_function.value.nil? || self.value.nil?
    fmap(maybe_function.value)
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
