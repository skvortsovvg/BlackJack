
require 'io/console'
require_relative 'card'
require_relative 'dealer'
require_relative 'hand'
require_relative 'drawing'

dealer    = Dealer.new
draw      = Drawing.new

4.times do 
  
  draw.refresh(dealer.hands)
  
  case STDIN.getch.capitalize
  when "Y"
    dealer.deal_card(:player).open
    next
  when "\e"
    break 
  when "N"
    dealer.open_dealer_hand { draw.refresh(dealer.hands) }
    dealer.new_deal 
  end

end

STDIN.getch
