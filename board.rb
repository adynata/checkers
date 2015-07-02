require_relative 'piece'
require_relative 'cursor'
require 'byebug'
require 'colorize'


class Board

  attr_accessor :grid, :cursor

  include Cursor

  MOVE_MAP = {
  "DOWN ARROW" => [1, 0],
  "RIGHT ARROW" => [0, 1],
  "UP ARROW" => [-1, 0],
  "LEFT ARROW" => [0, -1],
  "RETURN" => [0, 0]
  }

  def initialize
    @grid = Array.new(8) { Array.new(8) {EmptySquare.new} }
    # @cursor = [0, 0]
    populate_board
  end

  def populate_board
    place_pieces(:r)
    place_pieces(:b)
  end

  def place_pieces(color)
    if color == :r
      piece_places = red_positions
    else
      piece_places = black_positions
    end

    piece_places.each do |position|
      grid[position[0]][position[1]] = Piece.new(color, position, self)
    end

  end

  # def move_cursor
  #   possible_selection = get_move
  #   while on_board?(possible_selection)
  #     possible_selection = get_move
  #   end
  #   @cursor = possible_selection
  # end


  def on_board?(potential_move)
   potential_move.all? { |pos| pos.between?(0, 7) }
  end

  # def get_move
  #   next_move = show_single_key
  #   cursor_diff = MOVE_MAP[next_move]
  #   [@cursor, cursor_diff].transpose.map {|x| x.reduce(:+)}
  # end

  def black_positions
    black_positions = [
      [5, 1], [5, 3], [5, 5], [5, 7],
      [6, 0], [6, 2], [6, 4], [6, 6],
      [7, 1], [7, 3], [7, 5], [7, 7] ]
  end

  def red_positions
    red_positions = [
      [0, 0], [0, 2], [0, 4], [0, 6],
      [1, 1], [1, 3], [1, 5], [1, 7],
      [2, 0], [2, 2], [2, 4], [2, 6] ]
  end

  def render
    print "  "
    (0..7).each do |i|
      print " #{i} "
    end

    grid.each_with_index do |row, idx1|
      puts
      print "#{idx1} "
      row.each_with_index do |place, idx2|
        if @cursor == [idx1, idx2]
          print place.to_view.colorize(background: :red)
        elsif (idx1 + idx2) % 2 == 0
          # debugger
          print place.to_view.colorize(background: :blue)
        else
          print place.to_view.colorize(background: :light_blue)
        end
      end
    end
    puts
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] =  mark
  end


end


board = Board.new

board.render

piece = Piece.new(:r, [2,2], Board.new)

p piece.current_position

puts "slides"
p piece.valid_slides

puts "jumps"
p piece.valid_jumps
