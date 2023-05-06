# display.rb
require 'colorize'

class Display
  def initialize
    @view = {
      top: nil,
      middle: nil,
      bottom: nil
    }
  end

  # this receives an array of square objects, and returns a string for display
  # every square is treated as having a top, middle, and bottom pixel.  Contents of
  # each square will be displayed only in the middle pixel of the square.
  def build_row_string(row)
    output = { top: '', middle: '', bottom: '' }
    row.each do |square|
      output[:top] << square.pixels[:top]
      output[:middle] << square.pixels[:middle]
      output[:bottom] << square.pixels[:bottom]
    end
    output = add_row_header(row, output)
    [output[:top], output[:middle], output[:bottom]].join("\n")
  end

  private

  def add_row_header(row, output)
    output[:top].insert(0, '   ')
    output[:middle].insert(0, " #{row[0].position[1] + 1} ")
    output[:bottom].insert(0, '   ')
    output
  end

  def set_color(string, color)
    if color == 'black'
      string.on_black
    else
      string.on_white
    end
  end
end
