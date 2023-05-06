# bishop.rb
require_relative 'chess_piece'

# Bishop chess piece
class Bishop < ChessPiece
  def initialize(color)
    super()
    @color = color
  end
end
