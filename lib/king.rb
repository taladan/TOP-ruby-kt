# king.rb
require_relative 'chess_piece'

# King chess piece
class King < ChessPiece
  # King can move any single square in a straight line from current square
  def calculate_available_moves
    @available_moves = [
      [1, 1],
      [-1, -1],
      [-1, 1],
      [1, -1],
      [0, 1],
      [0, -1],
      [1, 0],
      [-1, 0]
    ]
  end
end
