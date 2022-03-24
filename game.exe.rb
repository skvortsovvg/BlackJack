
require 'io/console'
require_relative 'card'

# cards = "𝟚♠ 𝟛♠ 𝟜♠ 𝟝♠ 𝟞♠ 𝟟♠ 𝟠♠ 𝟡♠ 𝟙𝟘♠ 𝕁♠ ℚ♠ 𝕂♠ 𝔸♠".split(' ')
cards = "2♠ 3♠ 4♠ 5♠ 6♠ 7♠ 8♠ 9♠ 10♠ J♠ Q♠ K♠ A♠".split(' ')

SHIRT = "░░░░░░░░░"
NONE = "\t"
FACE  = %w(▓▓▓▓▓▓▓▓▓ ▓%%▓▓▓▓▓▓ ▓▓▓▓▓▓%%▓)
TABLE = "\t\t\t\tИ0 И1 И2 И3 И4 \t Д0 Д1 Д2 Д3 Д4"

def print_shift(text)
  print "\t\t\t\t\t\t" + text
end

def print_layout(player, dialer)

  7.times do |i|
     str = TABLE.dup
     
     player.each_with_index do |card, index|
      if card.nil? 
        str.gsub!("И"+index.to_s, NONE)
      elsif !card.open?
        str.gsub!("И"+index.to_s, SHIRT)
      else
        if i == 1
          value_part = FACE[1].gsub("%%", card.value)
          value_part.slice!(-1) if value_part.size > 9
          str.gsub!("И"+index.to_s,value_part)
        elsif i == 5  
          value_part = FACE.last.gsub("%%", card.value)
          value_part.slice!(1) if value_part.size > 9
          str.gsub!("И"+index.to_s, value_part)
        else
          str.gsub!("И"+index.to_s, FACE.first)
        end
      end
    end
    dialer.each_with_index do |card, index|
      if card.nil? 
        str.gsub!("Д"+index.to_s, NONE)
      elsif !card.open?
        str.gsub!("Д"+index.to_s, SHIRT)
      else
        if i == 1
          value_part = FACE[1].gsub("%%", card.value)
          puts value_part
          value_part.slice!(-1) if value_part.size > 9
          str.gsub!("Д"+index.to_s, value_part)
        elsif i == 5  
          str.gsub!("Д"+index.to_s, FACE.last.gsub("%%", card.value))
        else
          str.gsub!("Д"+index.to_s, FACE.first)
        end
      end
    end

    puts str

  end
end

start = true

loop do 

  system 'cls'

  input   = File.open("logo.txt",  "r")

  while (line = input.gets) do
   puts line
  end

  if start 
    print_shift "Нажмите любую клавиу для начала игры..."
    STDIN.getch
    print "\r"
    start = false
  end
  
  print_shift "======================================="
  
  puts 
  puts puts puts 
  player = [Card.new(cards.sample), Card.new(cards.sample), nil, nil, nil]
  player[0].open
  player[1].open

  dialer = [Card.new(cards.sample), Card.new(cards.sample), nil, nil, nil]

  print_layout(player, dialer)

  break if STDIN.getch == "\e"

end