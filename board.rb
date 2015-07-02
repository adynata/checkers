require_relative 'piece'
require 'byebug'
require 'colorize'

class EmptySquare
  # attr_reader

  def initialize
    @empty = true
  end

  def to_view
    "   "
  end

end

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {EmptySquare.new} }
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
        if (idx1 + idx2) % 2 == 0
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
