
require 'io/console'
require_relative 'card'
require_relative 'dealer'
require_relative 'hand'
require_relative 'drawing'

dealer    = Dealer.new
draw      = Drawing.new 

SMS = {draw: "НИЧЬЯ! Победила дружба!", player: "ВЫИГРЫШ! Вы явно побеждаете!", dealer: "ПРОИГРЫШ! Побеждает умный компютер!"}

loop do

msg = "Ещё карту? (Y/N) "

  loop do 
    
    draw.refresh(dealer.hands, msg)
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

  dealer.play { draw.refresh(dealer.hands, "Играет дилер...") }
  draw.refresh(dealer.hands, SMS[dealer.result] + " Ещё партию?")
  STDIN.getch
  dealer.new_deal

end

# STDIN.getch
