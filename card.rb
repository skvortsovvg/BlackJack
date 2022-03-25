class Card
  attr_reader :name, :suit, :value, :rating

  def initialize(rating, suit)
    @opened = false
    @rating = rating
    @suit   = suit
    @value  = card_value(value)
    @name   = rating + suit 
  end

  def card_value(value)
    if %w(J Q K).include?(value)
      10
    elsif value == "A"
      11
    else
      value.to_i
    end
  end 

  def open
    @opened = true
  end

  def opened?
    @opened
  end

end