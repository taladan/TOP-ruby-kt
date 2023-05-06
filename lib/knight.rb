# knight.rb
require_relative 'chess_piece'

# Knight chess piece
class Knight < ChessPiece
  def initialize(color)
    super()
    @color = color
  end
end
