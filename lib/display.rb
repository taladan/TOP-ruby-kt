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
    pixels = { top: '', middle: '', bottom: '' }
    string = '      '
    pixels.each do |pixel, _v|
      row.each do |square|
        pixels[:top] << set_color(string, square.color) if pixel == :top
        if pixel == :middle && !square.contents.nil?
          pixels[:middle] << set_color("  #{square.contents}   ", square.color)
        elsif pixel == :middle && square.contents.nil?
          # uncomment to display square names in center of each square
          # pixels[:middle] << set_color("  #{square.name}  ".blue, square.color)
          pixels[:middle] << set_color(string, square.color)
        end
        pixels[:bottom] << set_color(string, square.color) if pixel == :bottom
      end
    end

    # Add spacing row numbers to head of row
    pixels[:top].insert(0, '   ')
    pixels[:middle].insert(0, " #{row[0].position[1] + 1} ")
    pixels[:bottom].insert(0, '   ')
    [pixels[:top], pixels[:middle], pixels[:bottom]].join("\n")
  end

  private

  def set_color(string, color)
    if color == 'black'
      string.on_black
    else
      string.on_white
    end
  end
end
