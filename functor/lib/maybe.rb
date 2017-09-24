class Maybe
  def initialize(value)
    @value = value
  end

  def fmap(function)
  end

  def ==(other)
    other.value == self.value
  end

  attr_reader :value

  private
end
