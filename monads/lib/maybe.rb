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

  def bind(func_that_returns_maybe)
    return apply(func_that_returns_maybe).value if func_that_returns_maybe.is_a? Maybe
    apply(func_that_returns_maybe)
  end

  # ^ this is okay but we still have to know about which function call to use when
  # we could remove that decision process automagically?

  def chain(next_link)
    if next_link.is_a? Maybe
      flatten_result(apply(next_link))
    else
      flatten_result(fmap(next_link))
    end
  end

  def ==(other)
    other.value == self.value
  end

  attr_reader :value

  def flatten_result(result)
    if result.value.is_a? Maybe
      return result.value
    else
      return result
    end
  end

  private

  def compose(f, g)
    lambda { |*args| f.call(*g.call(*args)) }
  end
end
