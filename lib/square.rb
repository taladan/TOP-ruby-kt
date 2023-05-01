# square.rb

# Creates a graph node named 'square'
class Square
  attr_accessor :name,
                :neighbors_position,
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
end
