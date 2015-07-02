require_relative 'board'
require_relative 'player'
require 'byebug'

class InvalidMove < StandardError


end


class Game
  attr_reader :players
  attr_accessor :board

  def initialize(players)
    @players = players
    @board = Board.new
  end

  def current_player
    players.first
  end

  def play
    until game_won?
      play_turn
    end
    puts "Someone won this game!"
  end

  def play_turn
    system "clear"
  # begin
    board.render
    picked_position = prompt_for_input
    if valid_pos?(picked_position)
  # rescue
  #   # puts "not a valid move"
  #   retry
  # end
      starting_position = picked_position
    end
  # begin
    picked_position = get_second_position
    if valid_move?(starting_position, picked_position)
  # rescue
    # puts "Nope! You can't move there"
    # retry
  # end
      ending position = picked_position
    end
    #

    players.rotate
  end

  def valid_pos?(pos)
    # debugger
    board.on_board?(pos) && current_player_color?(pos)
  end

  def current_player_color?(pos)
    current_player.color && board[*pos].color
  end

  def prompt_for_input
    print "#{current_player.color}: please pick a position to move from (col, row)"
    get_position
  end

  def get_second_position
    print "#{current_player.color}: please pick a position to move to (col, row)"
    get_position
  end

  def get_position
    input = gets.chomp.split(",").map(&:to_i)
  end

  def valid_move?(start_pos, end_pos)
    


  def game_won?
    false
  end

end

players = [Player.new(:r), Player.new(:b)]

game = Game.new(players)

game.play
