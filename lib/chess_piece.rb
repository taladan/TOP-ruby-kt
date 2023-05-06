# chess_piece.rb

class ChessPiece
  attr_accessor :color, :current_square

  def initialize
    @color = nil
    @current_square = nil
    @avaiable_moves = nil
  end
end
