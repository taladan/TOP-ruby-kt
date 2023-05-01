# square.rb
require 'colorize'

# Creates a graph node named 'square'
class Square
  attr_accessor :name,
                :neighbors_positions,
                :neighbors_name,
                :position,
                :contents

  def initialize(name)
    @name = name
    @neighbors_positions = {}
    @neighbors_name = []
    @position = []
    @contents = nil
  end

  def view
    if @position[0].even? && @position[1].even?
      build_view.on_black
    elsif @position[0].even? && @position[1].odd?
      build_view.on_white
    elsif @position[0].odd? && @position[1].even?
      build_view.on_white
    elsif @position[0].odd? && @position[1].odd?
      build_view.on_black
    end
  end

  private

  def build_view
    "      \n  #{@contents.blue || ' '}   \n      "
  end
end
