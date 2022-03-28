class Dealer
  attr_reader :hands, :bank, :bid

  require_relative 'card'
  require_relative 'hand'

  SMS = {draw: "НИЧЬЯ! Победила дружба!", player: "ВЫИГРЫШ! Вы явно побеждаете!", dealer: "ПРОИГРЫШ! Побеждает умный компютер!"}
  
  def initialize
    @bank   = { dealer: 100, player: 100 }
  end

  def result
    who = if hands[:player].fail?  
      :dealer
    elsif hands[:dealer].fail?
      :player
    elsif hands[:dealer].score == hands[:player].score
      :draw
    else
      hands[:player].score > hands[:dealer].score ? :player : :dealer
    end
    
    @bank[who] += @bid
    @bid        = 0 
    return SMS[who]
  end

  def new_deal
    new_deck
    @bank.each { |k, v| @bank[k] -= 10 }
    @bid = 20
    @hands  = { dealer: Hand.new, player: Hand.new }
    2.times { deal_card(:player).open }
    2.times { deal_card(:dealer) }
  end

  def deal_card(whom)
    @hands[whom].add_card(@deck.shift)
  end

  def new_deck
    # "♡♧♢♤"
    @deck = []
    "♠♥♦♣".chars.each do |suit|
      %w(2 3 4 5 6 7 8 9 10 J Q K A).each { |value| @deck << Card.new(value, suit) }
    end
    @deck.shuffle!
  end

  def play
    hand = hands[:dealer]

    hand.cards.each do |card|
      card.open
      yield
      sleep(1)
    end

    loop do
      if hand.score >= 21 || hand.score > hands[:player].score || hands[:player].fail?
        return hand.played
      elsif
        deal_card(:dealer).open
        yield
        sleep(1)
      end
    end

  end

end

