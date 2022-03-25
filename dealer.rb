class Dealer
  attr_reader :deck, :hands
  
  def initialize
    new_deck
    new_deal
  end

  def new_deal
    @hands = { dealer: Hand.new, player: Hand.new }
    2.times { deal_card(:player).open }
    2.times { deal_card(:dealer) }
  end

  def deal_card(whom)
    card = deck.shift
    release << card 
    @hands[whom].add_card(card)
    card
  end

  def new_deck
    # "♡♧♢♤"
    "♠♥♦♣".chars.each do |suit|
      %w(2 3 4 5 6 7 8 9 10 J Q K A).each { |value| deck << Card.new(value, suit) }
    end
    deck.shuffle!
  end

  def deck
    @deck ||= []
  end

  def release
    @release ||= []
  end

  def open_dealer_hand
    hands[:dealer].cards.each do |card|
      card.open
      yield
      sleep(1)
    end
  end

end