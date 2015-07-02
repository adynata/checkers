# require 'colorize'
require 'byebug'
# require_relative 'board' #only when testing

class Piece
  attr_accessor :kinged, :current_position, :board
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

  def move(pos)
    # check to see if the move makes the piece a king

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

  #just used to generate moves
  def is_red?
    color == :r
  end

  def opponent_color
    self.color == :r ? :b : :r
  end


  def perform_moves(args)
    if valid_moves?
      perform_move_sequence
    end
  end

  def perform_move_sequence
  end

  def valid_slides
    all_slides.select { |pos| board[*pos].empty_square? }
  end

  def empty_square?
    false
  end

  def all_slides
    moves = []
    if self.kinged?
      KINGED_DELTAS.each do |delta|
        moves << trans_move(current_position, delta)
      end
    elsif self.is_red?
      RED_DELTAS.each do |delta|
        moves << trans_move(current_position, delta)
      end
    else
      BLACK_DELTAS.each do |delta|
        moves << trans_move(current_position, delta)
      end
    end
    moves
  end

  def trans_move(first_pos, diff)
    [first_pos, diff].transpose.map {|x| x.reduce(:+)}
  end

  def valid_jumps
    maybe_capturable = all_slides.select do |pos|
      board[*pos].color == opponent_color
    end
    maybe_capturable.select do |pos|
      pos_to_check = trans_move(current_position, pos)
      board[*pos_to_check].empty_square?
    end
  end

  def perform_slide(beg_pos, end_pos)
    board[*end_pos] = self
    current_position = end_pos
    board[*beg_pos] = EmptySquare.new
  end

  def perform_jump(beg_pos, end_pos)
    board[*end_pos] = self
    current_position = end_pos
    middle_pos = trans_move(end_pos, beg_pos)
    board[*middle_pos] = EmptySquare
    board[*beg_pos] = EmptySquare.new
  end


  def on_board?(pos) # can make this a call on object directly?
    potential_move.all? { |pos| pos.between?(0, 7) }
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



class EmptySquare
  attr_reader :color, :empty

  def initialize
    @empty = true
    @color = :n
  end

  def empty_square?
    true
  end

  def to_view
    "   "
  end

end
