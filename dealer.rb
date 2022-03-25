class Dealer
  attr_reader :deck, :hands
  
  def initialize
    new_deal
  end

  def result
    if hands[:player].score > 21  
      hands[:dealer].score <= 21 ? :dealer : :draw
    elsif hands[:dealer].score > 21
      hands[:player].score <= 21 ? :player : :draw
    elsif hands[:dealer].score == hands[:player].score
      :draw
    else
      hands[:player].score > hands[:dealer].score ? :player : :dealer
    end
  end

  def new_deal
    new_deck
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

  def play
    hand = hands[:dealer]

    hand.cards.each do |card|
      card.open
      yield
      sleep(1)
    end

    loop do
      if hand.score >= 21 || hand.score > hands[:player].score || hands[:player].played  && hands[:player].score > 21
        return hand.played
      elsif
        deal_card(:dealer).open
        yield
        sleep(1)
      end
    end

  end

end