require 'pry'
class TicTacToe

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [6,4,2],
  [0,3,6],
  [1,4,7],
  [2,5,8],
]
def initialize(board = nil)                  #default parameter set to nil if board is empty
  @board = board || Array.new(9, " ")       #instance var equal to argument, init array to 9 empty spaces

end

def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
end

def move(index, value)
  @board[index] = value
end

def position_taken?(index)
  @board[index] != " " && @board[index] != ""
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
end

def turn
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  char = current_player
  if valid_move?(index)
    move(index, char)
    display_board
  else
    turn
  end
end

def turn_count
  turns = 0                             #initialize turns variable starting at 0
  @board.each do |token|                 #iterate each element on board. token is variable label for our array to be passed into the block of code
    if token == "X" || token == "O"     #if tokens are either X or O add to turn count
      turns += 1
    end
  end
  return turns                           #returns turns. Listed in lab requirements. "Control return value of a method that uses iteraton in body"
end                                      #This return could also be just: turns. However including 'returns' helps understanding

def current_player
  turn_count % 2 == 0 ? "X" : "O"           #call #turn_count. Ternary operators ? : looks for true/false values then executes
end                                         #using a modulo. if condition is true ? then "X" : otherwise value "O"

def won?
  WIN_COMBINATIONS.detect do |win_combo|
    if (@board[win_combo[0]]) == "X" && (@board[win_combo[1]]) == "X" && (@board[win_combo[2]]) == "X"
      return win_combo
    elsif (@board[win_combo[0]]) == "O" && (@board[win_combo[1]]) == "O" && (@board[win_combo[2]]) == "O"
      return win_combo
    end
      false
  end
end

def full?
  @board.all? do |token| token != " "
  end
end

def draw?
  !(won?) && full?      #calls to methods
end

def over?
    won? || full? || draw?
end

def winner
  WIN_COMBINATIONS.detect do |win_combo|
    if (@board[win_combo[0]]) == "X" && (@board[win_combo[1]]) == "X" && (@board[win_combo[2]]) == "X"
      return "X"
    elsif (@board[win_combo[0]]) == "O" && (@board[win_combo[1]]) == "O" && (@board[win_combo[2]]) == "O"
      return "O"
    else
      nil
    end
  end
end

def play
  while over? == false
    turn
  end
  if won?
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  end
end

end


#def won?
  #WIN_COMBINATIONS.detect do |combo|
  #  position(combo[0]) == position(combo[1]) &&
  #  position(combo[1]) == position(combo[2]) &&
  #  position_taken?(combo[0])
  #end
#end

#def position(location)
#  @board[location.to_i]
#end
