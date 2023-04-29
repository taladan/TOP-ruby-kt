require 'colorize'

# Handle display of chess board of `n x m` size.  Default size is 8 x 8
class BoardDisplay
  def initialize(rows = 8, columns = 8)
    @ROWS = rows
    @COLUMNS = columns
    @SQUARE_HEIGHT = 3
    @EMPTY_PIXEL = '      '
    @OCCUPIED_PIXEL = '  K   '
    @EMPTY_SCAN = Array.new(@COLUMNS, @EMPTY_PIXEL)
  end

  # Display current state of chess board
  def display
    @ROWS.times do |row|
      puts build_row(@EMPTY_SCAN, row + 1, false) if row.even?
      puts build_row(@EMPTY_SCAN, row + 1, true) if row.odd?
    end
  end

  private

  #  builds 1/3 of a row of cells
  def build_scan(pixels)
    array = []
    pixels.each_with_index do |pixel, index|
      array << if index.even?
                 pixel.on_white
               else
                 pixel.on_black
               end
    end
    array
  end

  def flip_squares(pixels)
    array = []
    pixels.each_with_index do |pixel, index|
      array << if index.even?
                 pixel.on_black
               else
                 pixel.on_white
               end
    end
    array
  end

  # Builds a full row of checkered squares
  def build_row(pixels, row_number, alternate = false)
    row = ''
    counter = 0
    while counter < @SQUARE_HEIGHT
      if row_number.to_s.length < 2
        row += "#{row_number}" + ' ' * (@ROWS.to_s.length + 1) if counter.odd?
      elsif row_number.to_s.length >= 2
        row += "#{row_number}" + ' ' * @ROWS.to_s.length if counter.odd?
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
