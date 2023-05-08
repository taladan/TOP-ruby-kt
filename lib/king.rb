# king.rb

# King chess piece
module King
  # King can move any single square in a straight line from current square
  POSSIBLE_MOVES = [
    [1, 1],
    [-1, -1],
    [-1, 1],
    [1, -1],
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ]
end
