# piece_handling.rb
# Module file containing piece logic

# Handle piece logic
module Pieces
  @@valid_piece_names = %w[WK BK WQ BQ WB BB WN BN WR BR WP BP]
  # add piece to board.  Piece must be in two letter format: 'WK', 'BQ', 'WP', 'BB', etc
  # The first letter indicates the color of the piece, the last two letters indicate the piece
  # Also take a named position to add piece to ('a1-h8')

  def add_piece(piece, position)
    raise ArgumentError, 'Invalid Position' unless @valid_squares.include?(position.downcase)

    unless @@valid_piece_names.include?(piece.upcase)
      raise ArgumentError,
            "Invalid Piece name: Must be one of: #{@valid_piece_names}"
    end
    color = 'white' if piece[0].upcase == 'W'
    color = 'black' if piece[0].upcase == 'B'
    name = piece[1].upcase

    square = find_square_by_name(position.downcase)
    square.contents = ChessPiece.new(name, color, square)
    nil
  end

  # move a piece from a named square to a named square ('a1-h8')
  def move_piece(from_square, to_square)
    raise ArgumentError, 'Invalid Starting Position' unless @valid_squares.include?(from_square)
    raise ArgumentError, 'Invalid Ending Position' unless @valid_squares.include?(to_square)

    # load squares
    from = find_square_by_name(from_square)
    to = find_square_by_name(to_square)

    raise ArgumentError, 'No piece detected in starting Square' if from.contents.nil?

    # swap squares contents
    to.contents = from.contents
    from.contents = nil
  end
  
  private
  # Calculate squares piece can move to.  Accepts two, n-element arrays, returns one n-element array
  def add_current_and_possible_squares(current, possible)
    [current, possible].transpose.map { |x| x.reduce(:+) }
  end

  # Validate 2d array position either empty, occupied by teammate, occupied by enemy
  # Return nil if off board or occupied by team mate (invalid position to move to)
  # Return target square if on board and empty or on board and contains enemy piece
  def validate_position(target_position, color)
    return nil unless on_board?(target_position)

    target_square = find_square_by_position(target_position)
    # Empty square
    return target_square unless target_square.occupied?

    # occupied by enemy
    return target_square if target_square.occupied? && target_square.contents.color != color

    # occupied by teammate
    return nil if target_square.occupied? && target_square.contents.color == color
  end
end
