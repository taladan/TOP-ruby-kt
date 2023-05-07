# king.rb
require_relative 'chess_piece'

# King chess piece
class King < ChessPiece
  def initialize
    super()
    @possible_moves = [
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

  # King can move any single square in a straight line from current square
end
