# chess_piece.rb

# Parent class for all chess pieces
class ChessPiece
  attr_accessor :color, :current_square, :possible_moves

  def initialize(name, color, current_square)
    raise ArgumentError, 'Invalid Name' unless %w[K Q B N R P].include?(name)

    @color = color
    @name = name
    @current_square = current_square
    @possible_moves = nil
  end
end
