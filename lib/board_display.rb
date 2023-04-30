require 'colorize'
require 'pry-byebug'

# Handle display of chess board of `n x m` size.  Default size is 8 x 8
class BoardDisplay
  attr_accessor :CURRENTLY_OCCUPIED

  def initialize(rows = 8, columns = 8)
    @ROWS = rows
    @COLUMNS = columns
    @SQUARE_HEIGHT = 3
    @EMPTY_PIXEL = '      '
    @OCCUPIED_PIXEL = '  K   '
    @EMPTY_SCAN = Array.new(@COLUMNS, @EMPTY_PIXEL)
    @ALPHA = ('a'..'bb').to_a
    @CURRENTLY_OCCUPIED = [0, 0]
  end
  # @EMPTY_SCAN[@CURRENTLY_OCCUPIED[0]] = @OCCUPIED_PIXEL if row == @CURRENTLY_OCCUPIED[1]

  # Display current state of chess board
  def display
    @ROWS.times do |row|
      puts build_row(@EMPTY_SCAN, row, false) if row.even?
      puts build_row(@EMPTY_SCAN, row, true) if row.odd?
    end
    print '  ' * @ROWS.to_s.length
    @COLUMNS.times do |column|
      print "  #{@ALPHA[column]}   "
    end
    print "\n"
  end

  private

  # Build scan string (white/black/white/black)
  def build_scan(pixels)
    array = []
    pixels.each_with_index do |pixel, index|
      array << if index.even?
                 pixel.black.on_white
               else
                 pixel.white.on_black
               end
    end
    array
  end

  # Build alternate scan string (black/white/black/white)
  def flip_squares(pixels)
    array = []
    pixels.each_with_index do |pixel, index|
      array << if index.even?
                 pixel.white.on_black
               else
                 pixel.black.on_white
               end
    end
    array
  end

  # Builds a full row of checkered squares
  def build_row(pixels, row_number, alternate = false)
    row = ''
    counter = 0
    while counter < @SQUARE_HEIGHT
      pixels[@CURRENTLY_OCCUPIED[0]] = if row_number == @CURRENTLY_OCCUPIED[1] && counter == 1
                                         @OCCUPIED_PIXEL
                                       else
                                         @EMPTY_PIXEL
                                       end
      if row_number.to_s.length < 2
        row += "#{@ROWS - row_number}" + ' ' * (@ROWS.to_s.length + 1) if counter.odd?
      elsif row_number.to_s.length >= 2
        row += "#{@ROWS - row_number}" + ' ' * @ROWS.to_s.length if counter.odd?
      end
      row += ' ' * (@ROWS.to_s.length + 2) if counter.even?
      row += flip_squares(pixels).join if alternate
      row += build_scan(pixels).join unless alternate
      row += "\n"
      counter += 1
    end
    row
  end
end
