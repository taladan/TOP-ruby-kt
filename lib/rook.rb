# rook.rb
require_relative 'chess_piece'

# Rook chess piece
class Rook < ChessPiece
  def initialize(color)
    super()
    @color = color
  end
end
