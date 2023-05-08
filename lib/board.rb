# board.rb
require_relative 'square'
require_relative 'display'
require_relative 'piece_handler'
require_relative 'square_handler'
require_relative 'chess_piece'

# Generate a graph called 'Board' of nodes called 'squares'
class Board
  include Pieces
  include Squares
  include Display
  attr_accessor :squares
  attr_reader :columns, :rows, :display

  def initialize(columns = 8, rows = 8)
    @columns = columns
    @rows = rows
    @squares = []
    @valid_squares = nil
    generate_board
  end

  private

  # create board of squares return nil
  def generate_board
    # make squares
    @valid_squares = combine_columns_and_rows.to_a
    @valid_squares.each { |square| @squares << Square.new(square) }
    # gives the squares positions in space
    assign_square_positions
    # calculate neighbors and assign a color to square
    @squares.each do |square|
      assign_neighbors(square)
      square.assign_color
    end
    nil
  end

  # is the queried square a boundary square?
  def boundary?(square)
    # Square occupied
    return true if square.occupied?
    # Square is out of bounds
    if square.position[0].zero? || square.position[1].zero? || square.position[0] == 7 || square.position[1] == 7
      return true
    end

    # Square is empty, proceed
    false
  end

  # return an array of formatted column and row names - ex `a1 - h8`
  def combine_columns_and_rows
    array = []
    cols = column_labels
    rows = make_rows
    cols.each do |col|
      rows.each do |row|
        array << "#{col}#{row}"
      end
    end
    array
  end

  # return array of lettered columns from a - zz
  def column_labels
    alphas = ('a'..'zz').to_a
    array = []
    @columns.times do |column|
      array << alphas[column]
    end
    array
  end

  # create an array of row numbers from 1
  def make_rows
    array = []
    @rows.times do |row|
      array << row + 1
    end
    array
  end

  def generate_2d_array
    output = []
    (@columns * @rows).times { |num| output << [num / @columns, num % @rows] }
    output
  end

  def on_board?(position)
    rows = (0..@rows - 1).to_a
    cols = (0..@columns - 1).to_a
    row = position[1]
    col = position[0]
    rows.include?(row) && cols.include?(col)
  end
end
