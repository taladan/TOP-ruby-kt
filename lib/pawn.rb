# pawn.rb
require_relative 'chess_piece'

# Pawn chess piece
class Pawn < ChessPiece
  def initialize(color)
    super()
    @color = color
  end
end
