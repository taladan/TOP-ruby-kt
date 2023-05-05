# display.rb

class Display
  def initialize
    @view = {
      top: nil,
      middle: nil,
      bottom: nil
    }
  end

  # collate and return a string
  # Each square is divided into thirds.  view {top:stuff, middle:stuff, bottom:stuff}
  # gather the squares that belong in a row, then iterate through each square and
  # collect their strings into an array that can be joined on the back end.

  # To get all squares in a row, we can first get the square at position [0,row#], then find
  # that square's east neighbor, then that square's east neighbor, etc. until we have no more
  # east neighbors listed. (nil)
  # start = [7,7]

  # Once we have all the squares in that row, we can iterate through them and build their views
  def build_row_string(row)
    
  end

  private

  def recursively_build_row(square, output = [])
    # Assume square is first in its row
    return output << square if square.neighbors[:e].nil?

    output << square
    next_square = @board.find_square_by_name(square.neighbors[:e])
    recursively_build_row(next_square, output)
  end

  def build_view(_square)
    # This will all likely change
    if color == 'black'
      @view.top = (' ' * 6).on_black
      @view.middle = "  #{@square.contents&.blue || ' '} ".on_black
      @viewbottom = (' ' * 6).on_black
    elsif color == 'white'
      top = (' ' * 6).on_white
      middle = "  #{@square.contents&.blue || ' '} ".on_white
      bottom = (' ' * 6).on_white
    end
    [top, middle, bottom].join("\n")
  end
end
