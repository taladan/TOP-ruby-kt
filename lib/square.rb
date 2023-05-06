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
end
