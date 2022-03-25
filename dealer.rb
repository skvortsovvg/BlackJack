class Dealer
  attr_reader :deck

  def initialize
    new_deck
  end

  def new_deck
    # %w(♡ ♧ ♢ ♤)
    %w(♠ ♥ ♦️ ♣).each do |suit|
      %w(2 3 4 5 6 7 8 9 10 J Q K A).each { |value| deck << Card.new(value, suit) }
    end
    deck.shuffle!
  end

  def deck
    @deck ||= []
  end
end