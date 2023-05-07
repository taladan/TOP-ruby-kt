# chess_piece.rb

# Parent class for all chess pieces
class ChessPiece
  attr_accessor :color, :current_square

  def initialize(name, color, current_square)
    raise ArgumentError, 'Invalid Name' unless %w[K Q B N R P].include?(name)

    @color = color
    @name = name
    @current_square = current_square
    @available_moves = nil
    calculate_available_moves
  end

  def boundary?(square)
    # Square occupied
    return true if square.occupied?
    # Square is out of bounds
    return true if square.position[0] < 0 || square.position[1] < 0 || square.position[0] > 7 || square.position[1] > 7

    # Square is empty, proceed
    false
  end
end
