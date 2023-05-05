# board.rb
require_relative 'square'
require_relative 'display'

# Generate a graph called 'Board' of nodes called 'squares'
class Board
  attr_accessor :squares
  attr_reader :columns, :rows, :display

  def initialize(columns = 8, rows = 8)
    @columns = columns
    @rows = rows
    @squares = []
    @display = Display.new
    generate_board
  end

  # return square by name format columnrow - `a1`
  def find_square_by_name(name)
    @squares.each do |square|
      return square if square.name == name
    end
    nil
  end

  # return square object by positional space -  takes an array
  def find_square_by_position(position)
    @squares.each do |square|
      return square if square.position == position
    end
  end

  # returns the name of the square in position [col, row]
  def get_name_by_position(position)
    square = find_square_by_position(position)
    square.name
  end

  # return total number of squares in board
  def count
    squares.length
  end

  # Display handled by @display
  def update_display
    @rows.times do |row|
      puts @display.build_row_string(build_row(row))
    end
  end

  private

  # create board of squares
  def generate_board
    # make squares
    combine_columns_and_rows.to_a.each { |square| @squares << Square.new(square) }
    # gives the squares positions in space
    assign_square_positions
    # calculate neighbors and assign a color to square
    @squares.each do |square|
      assign_neighbors(square)
      square.assign_color
    end
    # explicitly return nothing
    nil
  end

  # return an array of formatted column and row names - ex `a1 - h8`
  def combine_columns_and_rows
    array = []
    cols = make_columns
    rows = make_rows
    cols.each do |col|
      rows.each do |row|
        array << "#{col}#{row}"
      end
    end
    array
  end

  # this will give squares positional information as an easier way to reference as a 2d array as well as name info
  # allows for some math operations like assign_neighbors
  def assign_square_positions
    position_array = generate_2d_array(@columns)
    @squares.each_with_index do |square, index|
      square.position = position_array[index]
    end
    nil
  end

  # assign each neighboring square's name to square, or nil if the calculated position if off board
  def assign_neighbors(square)
    {
      n: [1, 0],
      ne: [1, 1],
      e: [0, 1],
      se: [-1, 1],
      s: [-1, 0],
      sw: [-1, -1],
      w: [0, -1],
      nw: [1, -1]
    }.each do |k, v|
      calculated_position = [square.position[0] + v[0], square.position[1] + v[1]]
      if on_board?(calculated_position)
        neighbor = find_square_by_position(calculated_position)
        add_edge(square, neighbor, k)
      else
        square.neighbors[k] = nil
      end
    end
  end

  # return array of lettered columns from a - zz
  def make_columns
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

  def generate_2d_array(columns)
    a = (0..columns - 1).to_a
    a.product(a)
  end

  def on_board?(position)
    rows = (0..@rows - 1).to_a
    cols = (0..@columns - 1).to_a
    row = position[0]
    col = position[1]
    rows.include?(row) && cols.include?(col)
  end

  # This is a little raw.  If I were to refactor this, I'd set up a setter/getter function for neighbors in square.
  # This sets an unweighted, undirected edge between square and its `key` neighbor
  def add_edge(square, neighbor, key)
    opposites = { n: 's', ne: 'sw', e: 'w', se: 'nw', s: 'n', sw: 'ne', w: 'e', nw: 'se' }
    square.neighbors[key] = neighbor.name
    neighbor.neighbors[opposites[key].to_sym] = square.name
    nil
  end

  # recurse through all east neighbors, pack square and return when [:e].nil? == true
  def build_row(row, column = 0, output = [])
    square = find_square_by_position([column, row])
    return output << square if square.neighbors[:e].nil?

    output << square
    build_row(row + 1, column + 1, output)
  end
end
