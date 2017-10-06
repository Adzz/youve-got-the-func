class Monoid
  def mappend
    raise NotImplementedError
  end
end

class Addition < Monoid
  def initialize(value)
    @value = value
  end

  attr_reader :value

  def mappend(other_thing)
    Addition.new(@value + other_thing.value)
  end

  def ==(other)
    other.value == value
  end
end
