class Drawing

  SHIRT = "░░░░░░░░░"
  NONE = "\t"
  FACE  = %w(▓▓▓▓▓▓▓▓▓ ▓%%▓▓▓▓▓▓ ▓▓▓▓▓▓%%▓)
  D = ["  ДИЛЕР: ", "███▀▀▀███", "█▀══▀▀═▀█", "█═█═══█═█", "███═█═███", "██▄▄█▄▄██", "          "]
  P = ["███▀▀▀███", "█▀══▀▀═▀█", "█═█═══█═█", "███═█═███", "██▄▄█▄▄██", "          "]
  
  def initialize
    system 'cls'
    print_logo
    $player = "Владимир"
    P.unshift($player[..8] + ":")
    # STDIN.getch
  end

  def get_name
  end

  def refresh(hands)
    system 'cls'
    print_logo
    print_layout(hands)
    print_line
    print_s "\t Взять ещё карту (Y/N)? "; puts
    print_line
  end
  
  def print_s(text)
    puts "\t\t\t\t" + text
  end

  def print_line
    print_s "================================================================================"
    puts
  end
  
  def print_logo
    input   = File.open("logo.txt",  "r")
    while (line = input.gets) do puts line end
    print_line
  end

  def print_layout(hands)

    puts 

    hands.each do |key, hand|
      7.times do |i|
        
        str = ["\t\t\t\t"];
        str << (key == :dealer ? D[i] : P[i])

        (7-hand.cards.count).times { str << "\t"}
         
        hand.cards.each_with_index do |card, index|
          if !card.opened?
            str << SHIRT
          else
            if i == 1
              value_part = FACE[1].gsub("%%", card.name)
              value_part.slice!(-1) if card.rating == "10"
            elsif i == 5  
              value_part = FACE.last.gsub("%%", card.name)
              value_part.slice!(1) if card.rating == "10"
            else
              value_part = FACE.first
            end
            str << value_part
          end
        end
        if hand.score > 0
          str << "\t РЕЗУЛЬТАТ:" if i == 3
          str << "\t #{hand.score}" if i == 4
        end
        puts str.join(' ')
      end
        puts
    end
  end

end