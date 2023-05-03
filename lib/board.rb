# board.rb
require_relative 'square'

# Generate a graph called 'Board' of nodes called 'squares'
class Board
  attr_accessor :squares
  attr_reader :columns, :rows

  def initialize(columns = 8, rows = 8)
    @columns = columns
    @rows = rows
    @squares = []
    generate_board
  end

  def find_square_by_name(name)
    @squares.each do |square|
      return square if square.name == name
    end
    nil
  end

  def find_square_by_position(position)
    @squares.each do |square|
      return square if square.position == position
    end
  end

  def get_name_by_position(position)
    square = find_square_by_position(position)
    square.name
  end

  def count
    squares.length
  end

  private

  require 'pry-byebug'
  def generate_board
    combine_columns_and_rows.to_a.each { |square| @squares << Square.new(square) }
    assign_square_positions
    @squares.each do |square|
      assign_neighbors(square)
      square.assign_color
    end
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

  def assign_square_positions
    position_array = generate_2d_array(@columns)
    @squares.each_with_index do |square, index|
      square.position = position_array[index]
    end
    nil
  end

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
        # square.neighbor[k] = calculated_position
        neighbor = find_square_by_position(calculated_position)
        add_edge(square, neighbor, k)
      else
        square.neighbors[k] = nil
      end
    end
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

  def add_edge(square, neighbor, key)
    binding.pry if square.name == 'h8'
    opposites = { n: 's', ne: 'sw', e: 'w', se: 'nw', s: 'n', sw: 'ne', w: 'e', nw: 'se' }
    square.neighbors[key] = neighbor
    neighbor.neighbors[opposites[key].to_sym] = square
    nil
  end
end
