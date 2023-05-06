# square.rb
require 'colorize'
require_relative 'display'

# Creates a graph node named 'square'
class Square
  attr_accessor :name,
                :neighbors,
                :position,
                :contents,
                :color

  def initialize(name)
    @name = name
    @neighbors = {
      n: nil,
      ne: nil,
      e: nil,
      se: nil,
      s: nil,
      sw: nil,
      w: nil,
      nw: nil
    }
    @position = []
    @contents = nil
    @color = nil
  end

  def assign_color
    if (@position[0].even? && @position[1].even?) || (@position[0].odd? && @position[1].odd?)
      @color = 'black'
    elsif (@position[0].even? && @position[1].odd?) || (@position[0].odd? && @position[1].even?)
      @color = 'white'
    end
  end

  def head_of_row?
    position[1] == 0
  end

  def pixels
    pad = '      '.on_black if @color == 'black'
    pad = '      '.on_white if @color == 'white'
    mid = "  #{contents}   ".on_black if @color == 'black' && !@contents.nil?
    mid = "  #{contents}   ".on_white if @color == 'white' && !@contents.nil?
    # uncomment for square names in center of each square
    # mid = "  #{name}  ".on_black if @color == 'black' && @contents.nil?
    # mid = "  #{name}  ".on_white if @color == 'white' && @contents.nil?
    mid = pad.on_black if @color == 'black' && @contents.nil?
    mid = pad.on_white if @color == 'white' && @contents.nil?

    { top: pad, middle: mid, bottom: pad }
  end
end
