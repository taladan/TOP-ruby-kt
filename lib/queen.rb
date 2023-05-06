# queen.rb
require_relative 'chess_piece'

# Queen Chess Piece
class Queen < ChessPiece
  def initialize(color)
    super()
    @color = color
  end
end
