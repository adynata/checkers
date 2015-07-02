# require 'colorize'
require 'byebug'

class Piece
  attr_accessor :kinged, :current_position
  attr_reader :color

  KINGED_DELTAS = [[-1,-1], [-1, 1], [1, 1], [1, -1]]

  RED_DELTAS = [[1, -1], [1, 1]]
  BLACK_DELTAS = [[-1, -1], [-1, 1]]

  def initialize(color, position, board)
    @current_position = position
    @board = board
    @color = color
    @kinged = false
    # debugger
  end

  def to_view
    if kinged?
      determine_color(" ♚ ")
    else
      determine_color(" ⚉ ")
    end
  end

  def determine_color(el)
    if self.color == :b
      return el.colorize(:black)
    else
      return el.colorize(:magenta)
    end
  end

  def kinged?
    kinged
  end

  def is_red?
    color == :r
  end

  def perform_moves(args)
    if valid_moves?
      perform_move_sequence
    end
  end

  def perform_slide

  end

  def perform_jump
    # removes a piece from the board
  end

  def perform_move_sequence
  end

  def all_moves
    moves = []
    if self.kinged?
      KINGED_DELTAS.each do |delta|
        moves << [current_position, delta].transpose.map {|x| x.reduce(:+)}
      end
    elsif self.is_red?
      RED_DELTAS.each do |delta|
        moves << [current_position, delta].transpose.map {|x| x.reduce(:+)}
      end
    else
      BLACK_DELTAS.each do |delta|
        moves << [current_position, delta].transpose.map {|x| x.reduce(:+)}
      end
    end
    p moves
  end

  def valid_moves?
    # dup the board
    # call perform moves
    # raise an InvalidMove error if it fails
    # if no error raised, return true
    # if multiple moves, all moves must be jumps
    # check every move
  end


end


# piece = Piece.new(:r, [1,1], "board")

# piece.all_moves
