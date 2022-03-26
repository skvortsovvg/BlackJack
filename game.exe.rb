
require 'io/console'
require_relative 'card'
require_relative 'dealer'
require_relative 'hand'
require_relative 'drawing'

SMS = {draw: "НИЧЬЯ! Победила дружба!", player: "ВЫИГРЫШ! Вы явно побеждаете!", dealer: "ПРОИГРЫШ! Побеждает умный компютер!"}

$player = ""

dealer    = Dealer.new
draw      = Drawing.new

loop do

msg = "Ещё карту? (Y/N) "

  loop do 
    
    draw.refresh(msg, dealer.hands)
    break if dealer.hands[:player].played?

    case STDIN.getch.capitalize
    when "Y"
      dealer.deal_card(:player).open
      next
    when "\e"
      exit 
    when "N"
      break
    end

  end

  dealer.play { draw.refresh("Играет дилер...", dealer.hands) }
  draw.refresh(SMS[dealer.result] + " Ещё партию?", dealer.hands)
  STDIN.getch
  dealer.new_deal

end

# STDIN.getch
