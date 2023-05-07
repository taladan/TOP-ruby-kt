# queen.rb
require_relative 'chess_piece'

# Queen Chess Piece
class Queen < ChessPiece
  # Queen can move to any square as long as it's a straight line, left, right, up, down, or diagonal from current position
  def initialize
    super()
    @possible_moves =
  end
end
