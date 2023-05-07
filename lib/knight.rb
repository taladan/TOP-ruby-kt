# knight.rb
require_relative 'chess_piece'

# Knight chess piece
class Knight < ChessPiece
  def initialize
    super()
    @possible_moves = [
      [1, 2],
      [-1, 2],
      [1, -2],
      [-1, -2],
      [2, 1],
      [-2, 1],
      [2, -1],
      [-2, -1]
    ]
  end

  # Knight can move any combination of 2,1 squares
  def calculate_available_moves; end
end
