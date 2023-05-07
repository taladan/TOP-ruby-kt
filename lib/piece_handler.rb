# piece_handling.rb
# Module file containing piece logic

module Pieces
  # add piece to board.  Piece must be in three letter format: 'WKi', 'BQu', 'WPa', 'BBi', etc
  # The first letter indicates the color of the piece, the last two letters indicate the piece
  # Also take a named position to add piece to ('a1-h8')
  def add_piece(piece, position)
    raise ArgumentError, 'Invalid Position' unless @valid_squares.include?(position)

    square = find_square_by_name(position)
    square.contents = piece
    nil
  end

  # move a piece from a named square to a named square ('a1-h8')
  def move_piece(from_square, to_square)
    raise 'Invalid Starting Position' unless @valid_squares.include?(from_square)
    raise 'Invalid Ending Position' unless @valid_squares.include?(to_square)

    # load squares
    from = find_square_by_name(from_square)
    to = find_square_by_name(to_square)

    raise 'Empty Square' if from.contents.nil?

    # swap squares contents
    to.contents = from.contents
    from.contents = nil
  end
end
