# main.rb
require 'set'
require_relative './lib/board'

# Board builds the chessboard graph, handling edges and piece movement
@board = Board.new

# return true if x/y coordinates are on the board
def valid_position?(x, y, n)
  return false if x < 0 || y < 0 || x >= n || y >= n

  true
end

# Get starting square
def get_start
  start = nil
  until @board.on_board?(@board.get_position_by_name(start))
    puts 'Please enter a starting position for our Knight:'
    puts 'It must be in chess notation (d3, a1, h5..etc)'
    puts 'Starting Position: '
    start = gets.chomp
  end
  start
end

# Get target square
def get_target
  target_square = nil
  until @board.on_board?(@board.get_position_by_name(target_square))
    puts 'Thank you.  Please enter a target square: '
    puts 'It must be in chess notation (d3, a1, h5..etc)'
    puts 'Target Position: '
    target_square = gets.chomp
  end
  target_square
end

# Knight's movements
@row = [2, 2, -2, -2, 1, 1, -1, -1]
@col = [-1, 1, 1, -1, 2, -2, 2, -2]

# Breadth first search to find shortest distance between start and target
def find_shortest_distance(start, target, size)
  # Visited squares
  visited = Set.new

  # create a queue and enqueue the first node
  start.dist = 0
  q = Queue.new
  q << start

  while q
    square = q.pop
    x = square.x
    y = square.y
    dist = square.dist
    output = [dist, visited]
    return output if x == target.x && y == target.y

    next if visited.include?(square)

    visited.add(square)

    # possible_moves = @board.calculate_possible_moves(square.name)

    for i in 0...@row.length
      x1 = x + @row[i]
      y1 = y + @col[i]
      next unless valid_position?(x1, y1, size)

      next_square = @board.find_square_by_position([x1, y1])
      next_square.dist = dist + 1
      next_square.prev = square if next_square.prev.nil?
      q << next_square
    end
  end
  Float::INFINITY
end

# Return an array of square objects [start, target]
def set_positions
  [@board.find_square_by_name(get_start), @board.find_square_by_name(get_target)]
end

# Display output
def display(target_pos, start_pos, traverse)
  # Place white knight on board in starting position, search by name
  @board.add_piece('wn', start_pos.name)
  # display the starting position

  # build the array of moves to the shortest path
  knights_path = build_positions_list(start_pos, target_pos)
  move = 0

  # track prior steps
  previous_step = start_pos.name

  knights_path.each do |current_step|
    # handle display of first placement of piece on board
    if current_step == start_pos.name
      # display starting position
      puts "\n\n"
      puts "Beginning position: #{start_pos.name}"
      puts "\n"
      @board.update_display
      # @board.move_piece(previous_step, current_step)
      move += 1
      next
    end

    # move piece to current square
    @board.move_piece(previous_step, current_step)
    # set square we're moving from
    previous_step = current_step

    # Move the piece

    # Clear the screen
    system('clear')

    # build text output
    puts "Total Number of squares visited: #{traverse[1].length}"
    puts "The minimum number of steps required is #{traverse[0]}"
    puts "Move:\t #{move}: #{current_step}"
    # Show the board
    @board.update_display
    print knights_path
    print "\n"
    move += 1
    sleep(2)
  end
end

# build array of position names ('a1','d3'...etc)
def build_positions_list(start, target)
  target
  path = []
  while target != start
    path.unshift(target.name)
    target = target.prev
  end

  path.unshift(start.name)
  path
end

# main function
def main
  start_pos, target_pos = set_positions
  traverse = find_shortest_distance(start_pos, target_pos, @board.columns)
  display(target_pos, start_pos, traverse)
end

main
