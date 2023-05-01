# board.rb
require_relative 'square'

# Generate a graph called 'Board' of nodes called 'squares'
class Board
  attr_accessor :vertices

  def initialize(columns = 8, rows = 8)
    @columns = columns
    @rows = rows
    @squares = []
    @nb = {
      n: [1, 0],
      ne: [1, 1],
      e: [0, 1],
      se: [-1, 1],
      s: [-1, 0],
      sw: [-1, -1],
      w: [0, -1],
      nw: [1, -1]
    }
    generate_board
  end

  def add_square(name)
    @squares << Square.new(name)
  end

  def add_edge(start_name, end_name, undirected = true)
    from = @squares.index { |square| square.name == start_name }
    to = @squares.index { |square| square.name == end_name }
    @squares[from].neighbors_name[to] = true
    return unless undirected

    squares[to].neighbors_name[from] = true
  end

  def find_vertex_by_name(name)
    @squares.each do |square|
      return square if square.name == name
    end
    nil
  end

  def find_vertex_by_position(position)
    @squares.each do |square|
      return square if square.position == position
    end
  end

  def get_name_by_position(position)
    square = find_vertex_by_position(position)
    square.name
  end

  def count
    squares.length
  end

  require 'pry-byebug'

  def assign_square_positions
    position_array = generate_2d_array(@columns)
    @squares.each_with_index do |square, index|
      square.position = position_array[index]
    end
    nil
  end

  def assign_neighbors(square)
    square = find_vertex_by_name(square)

    @nb.each do |_, v|
      square.neighbors_position << [square.position[0] + v[0], square.position[1] + v[1]]
    end
  end

  private

  def generate_board
    # stop = "#{alphas[@columns - 1]}#{@columns - 1}"
    combine_columns_and_rows.to_a.each { |square| add_square(square) }
    assign_square_positions
  end

  def make_columns
    alphas = ('a'..'zz').to_a
    array = []
    @columns.times do |column|
      array << alphas[column]
    end
    array
  end

  def make_rows
    array = []
    @rows.times do |row|
      array << row + 1
    end
    array
  end

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

  def generate_2d_array(columns)
    a = (0..columns - 1).to_a
    b = (0..columns - 1).to_a
    a.product(b)
  end
end
