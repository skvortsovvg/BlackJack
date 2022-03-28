
require 'io/console'
require_relative 'dealer'
require_relative 'drawing'

dealer    = Dealer.new
draw      = Drawing.new

loop do

  dealer.new_deal

  loop do 
    
    draw.refresh("Ещё карту? (Y/N)", dealer)
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

  dealer.play { draw.refresh("Играет дилер...", dealer) }
  draw.refresh(dealer.result + " Ещё партию? (Y/N) (Esc - выход)", dealer)
  
  case STDIN.getch.capitalize
  when "\e" || "N"
    exit 
  end
  
  if dealer.bank[:player] == 0 or dealer.bank[:dealer] == 0
    draw.refresh("ИГРА ОКОНЧЕНА! Денег нет! Перезапустить? (Y/N) (Esc - выход)")
  
    case STDIN.getch.capitalize
    when "\e" || "N"
      exit 
    end

    dealer = Dealer.new
  
  end
  
end

# STDIN.getch
