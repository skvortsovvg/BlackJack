class Dealer
  attr_reader :deck, :hands, :bank, :bid

  require_relative 'card'
  require_relative 'hand'

  SMS = {draw: "НИЧЬЯ! Победила дружба!", player: "ВЫИГРЫШ! Вы явно побеждаете!", dealer: "ПРОИГРЫШ! Побеждает умный компютер!"}
  
  def initialize
    @bank   = { dealer: 20, player: 20 }
    @bid    = 0
  end

  def print_deck
    puts @deck.map { |card| card.name }.inspect
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
    SMS[who]
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
    card = deck.shift
    release << card 
    @hands[whom].add_card(card)
    card
  end

  def new_deck
    # "♡♧♢♤"
    @deck = []
    "♠♥♦♣".chars.each do |suit|
      %w(2 3 4 5 6 7 8 9 10 J Q K A).each { |value| @deck << Card.new(value, suit) }
    end
    @deck.shuffle!
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

