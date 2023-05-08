# knight.rb

# Knight chess piece
module Knight
  # Knight can move any combination of 2,1 squares
  @possible_moves = [
    [1, 2],
    [-1, 2],
    [1, -2],
    [-1, -2],
    [2, 1],
    [-2, 1],
    [2, -1],
    [-2, -1]
  ]
end
