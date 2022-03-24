class Card
  attr_reader :value

  def initialize(value)
    @open = false
    @value = value
  end

  def open
    @open = true
  end

  def open?
    @open
  end

end