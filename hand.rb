class Hand
  attr_reader :cards, :score

  def initialize()
    @cards  = []
    @played = false 
  end

  def played
    @played = true
  end

  def played?
    @played
  end

  def fail?
    @fail
  end

  def add_card(card)
    @cards << card
    @score  = calculate
    @played = @score >= 21
    @fail   = @score > 21
    return card
  end

  def calculate(open_cards = false)
    @cards.sort_by { |card| card.value }.inject(0) do |sum, card|
      if open_cards && !card.opened?
        sum
      elsif card.value == 11
        sum + card.value > 21 ? sum + 1 : sum + card.value
      else
        sum + card.value
      end
    end 
  end

end