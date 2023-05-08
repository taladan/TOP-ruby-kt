# king.rb

# King chess piece
module King 
  # King can move any single square in a straight line from current square
    @possible_moves = [
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
end
