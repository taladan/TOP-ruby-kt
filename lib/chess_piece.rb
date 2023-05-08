# chess_piece.rb
require_relative 'king'
require_relative 'queen'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'

# Parent class for all chess pieces
class ChessPiece
  include King
  include Queen
  include Bishop
  include Knight
  include Rook
  include Pawn
  attr_accessor :current_square
  attr_reader :name, :color, :possible_moves

  def initialize(name, color, current_square)
    raise ArgumentError, 'Invalid Name' unless %w[K Q B N R P].include?(name)

    @color = color
    @name = name
    @current_square = current_square
    @possible_moves = nil
    colorize_name
  end

  private

  # Apply color to piece
  def colorize_name
    @name = @name.red if @color == 'white'
    @name = @name.blue if @color == 'black'
  end
end
