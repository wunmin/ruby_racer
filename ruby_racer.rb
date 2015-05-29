# require_relative 'racer_utils'
require_relative 'racer_utils.rb'
require 'byebug'

class RubyRacer
  attr_reader :players, :length

  def initialize(players, length = 30)
    @length = length
      count = 0
      $scores = {}
      while count < players.length
          $scores[players[count]] = 0
          count += 1
      end


      # p "Running initialize"
      p $scores
  end


  def finished?
    # p "Running finished?"

    $scores.each do |key, value|
        if value >= 30
           @winn = key
           $scores[key] = 30
           return false
           break
        end
    end
    return true

  end

  # Returns the winner if there is one, +nil+ otherwise
  def winner
    # p "Running winner"

     return @winn

  end

  # Rolls the dice and advances +player+ accordingly
  def advance_player!(player)
    @player = player
    # p "Running advance_player!"
      @die = Die.new
      if $scores[player] <= 30
        $scores[player] += @die.roll
      end

      puts $scores

  end

  # Prints the current game board
  # The board should have the same dimensions each time
  # and you should use the "reputs" helper to print over
  # the previous board
  def print_board
    # p "Running print_board"
    # 30.times do reputs(" | ")
      # string = String.new
      # 1..30.times do
      #   string << " |"
      # end
      # string[$scores[@player]] = @player
      # reputs(string)
      array_a = []
      array_b =[]
      1..30.times do
        array_a << " |"
        array_b << " |"
      end
      array_a[$scores["a"]-1] = "a|"
      reputs(array_a.join)
      array_b[$scores["b"]-1] = "b|"
      reputs(array_b.join)
    end
end

players = ['a', 'b']

game = RubyRacer.new(players)

# This clears the screen, so the fun can begin
clear_screen!


while game.finished?
  players.each do |player|
    # This moves the cursor back to the upper-left of the screen
    move_to_home!
    $player = player

    # We print the board first so we see the initial, starting board
    game.print_board
    # p "first print_board"
    game.advance_player!(player)

    # We need to sleep a little, otherwise the game will blow right past us.
    # See http://www.ruby-doc.org/core-1.9.3/Kernel.html#method-i-sleep
    sleep(0.5)
  end
end

# The game is over, so we need to print the "winning" board
game.print_board
# p "second print_board"

puts "Player '#{game.winner}' has won!"