# rook.rb
require_relative 'chess_piece'

# Rook chess piece
class Rook < ChessPiece
  # Rook can move any number of squares in a straight line, left/right/up/down, no diagonals
  def initialize
    super()
    @possible_moves =
  end
end
