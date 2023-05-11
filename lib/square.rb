# square.rb
require 'colorize'
require_relative 'display'

# Creates a graph node named 'square'
class Square
  attr_reader :x, :y
  attr_accessor :name,
                :neighbors,
                :position,
                :contents,
                :color,
                :dist,
                :prev

  def initialize(name)
    @name = name
    @neighbors = { n: nil, ne: nil, e: nil, se: nil, s: nil, sw: nil, w: nil, nw: nil }
    @position = []
    @contents = nil
    @color = nil
    @x = nil
    @y = nil
    # Required for Knight's Travails
    @dist = 0
    @prev = nil
  end

  # Assign square color based on position within board.  Upper left & Lower right squares == whitejj
  def assign_color
    if (@position[0].even? && @position[1].even?) || (@position[0].odd? && @position[1].odd?)
      @color = 'black'
    elsif (@position[0].even? && @position[1].odd?) || (@position[0].odd? && @position[1].even?)
      @color = 'white'
    end
  end

  # Return true/false if square at beginning of row
  def head_of_row?
    position[1].zero?
  end

  # Return true/false if square occupied
  def occupied?
    !@contents.nil?
  end

  # Build square display
  def pixels
    pad = '      '.on_black if @color == 'black'
    pad = '      '.on_white if @color == 'white'
    mid = "  #{@contents.name}   ".on_black if @color == 'black' && !@contents.nil?
    mid = "  #{@contents.name}   ".on_white if @color == 'white' && !@contents.nil?
    # uncomment for square names in center of each square
    # mid = "  #{name}  ".on_black if @color == 'black' && @contents.nil?
    # mid = "  #{name}  ".on_white if @color == 'white' && @contents.nil?
    mid = pad.on_black if @color == 'black' && @contents.nil?
    mid = pad.on_white if @color == 'white' && @contents.nil?

    { top: pad, middle: mid, bottom: pad }
  end

  def assign_positions(arr)
    @position = arr
    @x = @position[0]
    @y = @position[1]
  end
end
