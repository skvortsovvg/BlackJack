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

  def add_card(card)
    @cards << card
    @played = score >= 21
  end

  def score
    @cards.sort_by { |card| card.value }.inject(0) do |sum, card|
      # if !card.opened?
      #   sum
      # els
      if card.value == 11
        sum + card.value > 21 ? sum + 1 : sum + card.value
      else
        sum + card.value
      end
    end 
  end

end