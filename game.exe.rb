
require 'io/console'

def print_shift(text)
  print "\t\t\t\t\t\t" + text
end

system 'cls'

input   = File.open("logo.txt",  "r")

while (line = input.gets) do
 puts line
end

print_shift "Нажмите любую клавиу для начала игры..."
STDIN.getch
print "\r"
print_shift "======================================="
STDIN.getch