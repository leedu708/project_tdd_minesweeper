class Field

  attr_accessor :mine, :flag, :shown, :adjacent_mines
  attr_reader :coordinates, :adjacent_fields

  # initialize necessary variables
  def initialize(coordinates, grid_size)
    @coordinates = coordinates
    @grid_size = grid_size
    @mine = false
    @flag = false
    @shown = false
    @adjacent_fields = find_adjacent_fields(@coordinates)
    @adjacent_mines = 0
  end

  # sets field to contain mine
  def set_mine
    @mine = true
  end

  # place or remove flag
  def set_flag
    @flag = !@flag
  end

  # show field
  def show_field
    @shown = true
  end

  # return coordinates of adjacent fields
  def find_adjacent_fields(coordinates = @coordinates)
    a = coordinates[0]
    b = coordinates[1]
    adj_fields = []

    # check through columns then rows
    (a - 1).upto(a + 1) do |column|
      (b - 1).upto(b + 1) do |row|

        # return column and row if the coordinates are
        # 1. on the board
        # 2. not the current field
        if (row >= 1 && row <= @grid_size) && (column >= 1 && column <= @grid_size) && !(column == a && row == b)

          adj_fields.push([column, row])
        end
      end
    end

    adj_fields
  end

end