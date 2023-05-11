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

  # Return an array of valid and open squares to move to
  def calculate_possible_moves(from_square)
    possible_moves = []
    # load piece
    piece = find_square_by_name(from_square).contents
    # read current position from piece
    current = piece.current_square.position

    # loop through possible moves and build array
    piece.possible_moves.each do |move|
      possible_moves << validate_position(add_current_and_possible_squares(current, move), piece.color)
    end
    possible_moves.compact
  end

  # move a piece from a named square to a named square ('a1-h8')
  def move_piece(from_square, to_square, override: false)
    raise ArgumentError, 'Invalid Starting Position' unless @valid_squares.include?(from_square)
    raise ArgumentError, 'Invalid Ending Position' unless @valid_squares.include?(to_square)

    # If override is false, we stick with the piece's movement patterns.
    # If override is true, we ignore piece's movement patterns and just
    # place piece where we desire.
    if override == false
      valid_moves = get_square_positions(calculate_possible_moves(from_square))
      unless valid_moves.include?(find_square_by_name(to_square).position)

        raise ArgumentError,
              "Square #{to_square} is not a valid target"
      end

      put_piece(from_square, to_square)
    else
      put_piece(from_square, to_square)
    end
  end

  private

  # Calculate squares piece can move to.  Accepts two, n-element arrays, returns one n-element array
  def add_current_and_possible_squares(current, possible)
    [current, possible].transpose.map { |x| x.reduce(:+) }
  end

  # Takes an array of squares and gets their 2d array positions
  def get_square_positions(array_of_squares)
    output = []
    array_of_squares.each { |square| output << square.position }
    output
  end

  def put_piece(from_square, to_square)
    # load squares
    from = find_square_by_name(from_square)
    to = find_square_by_name(to_square)

    # load piece
    piece = from.contents

    raise ArgumentError, 'No piece detected in starting Square' if from.contents.nil?

    # swap squares contents
    to.contents = from.contents
    from.contents = nil
    piece.current_square = to
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
