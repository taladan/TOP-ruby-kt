# bishop.rb
require_relative 'chess_piece'

# Bishop chess piece
class Bishop < ChessPiece
  # Bishop can move any number of diagonal spaces.  Must land on same color square it started on
  def calculate_available_moves
    @available_moves
  end
end
