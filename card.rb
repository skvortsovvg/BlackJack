class Card
  attr_reader :name, :suit, :value, :rating

  def initialize(rating, suit)
    @opened = false
    @rating = rating
    @suit   = suit
    @value  = card_value(rating)
    @name   = rating + suit 
  end

  def card_value(value)
    if %w(J Q K).include?(value)
      return 10
    elsif value == "A"
      return 11
    else
      return value.to_i
    end
  end 

  def open
    @opened = true
  end

  def opened?
    @opened
  end

end