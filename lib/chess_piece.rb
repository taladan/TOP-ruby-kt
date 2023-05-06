# chess_piece.rb

# Parent class for all chess pieces
class ChessPiece
  attr_accessor :color, :current_square

  def initialize
    @name = nil
    @color = nil
    @current_square = nil
    @available_moves = nil
  end
end
