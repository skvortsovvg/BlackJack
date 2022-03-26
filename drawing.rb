class Drawing

  SHIRT = "░░░░░░░░░"
  NONE = "\t"
  FACE  = %w(▓▓▓▓▓▓▓▓▓ ▓%%▓▓▓▓▓▓ ▓▓▓▓▓▓%%▓)
  D = ["  ДИЛЕР: ", "███▀▀▀███", "█▀══▀▀═▀█", "█═█═══█═█", "███═█═███", "██▄▄█▄▄██", "          "]
  P = ["███▀▀▀███", "█▀══▀▀═▀█", "█═█═══█═█", "███═█═███", "██▄▄█▄▄██", "          "]
  
  def initialize
    # print_logo
    # print "\t\t\t\t\tЗдравствуйте, игрок! Представьтесь, пожалуйста: " 
    # $player = gets.chomp.capitalize[..8]
    # refresh("Добро пожаловать, #{$player}! Нажмите клавишу, чтобы начать игру... ") 
    # STDIN.getch
    $player = "Владимир"
    P.unshift($player + ":")
  end

  def get_name
  end

  def refresh(msg, hands = nil)
    print_logo
    if !hands.nil?
      print_layout(hands)
      print_line
    end
    print_s "\t #{msg} "; puts
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
    system 'cls'
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
          str << "\t #{hand.score} #{"X !ПЕРЕБОР!" if hand.score > 21}" if i == 4
        end
        puts str.join(' ')
      end
        puts
    end
  end

end