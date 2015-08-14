require_relative 'field'

Class Board
  attr_reader :flags_remaining, :board, :mine_coords

  def initialize(grid_size = 8, input_mines = 10)

    @grid_size = grid_size
    @board = init_board(grid_size, input_mines)
    @flags_remaining = input_mines
    @mine_coords = mine_coords
    sum_mines

  end

  def init_board(grid_size, input_mines)
    board = []

    # set up the board
    1.upto(grid_size) do |row|
      current_row = []

      # set up fields in current_row
      1.upto(grid_size) do |column|
        current_row << Field.new([row, column], grid_size)
      end

      board << current_row
    end

    create_mines(board, input_mines)
    board
  end

  # sets the fields to contain mines as input by the user
  def create_mines(board, mines)
    until mines == 0
      random_field = board.sample.sample

      # only sets mine if current field does not already contain a mine
      if random_field.mine
        continue
      else
        random_field.set_mine
        mines -= 1
      end
    end
  end

  # get a field based on coordinates
  def get_field(coordinates)
    @board.flatten.each do |field|
      return field if field.coordinates == coordinates
    end
  end

  # return the number of adjacent mines
  def sum_mines
    @board.flatten.each do |field|
      adjacent_mines = 0

      field.find_adjacent_fields.each do |adj_field|
        if get_field(adj_field).mine
          adjacent_mines += 1
        end
      end

      field.adjacent_mines = adjacent_mines
    end
  end

  # adds or removes a flag
  def flag_field(coordinates)

    field = get_field(coordinates)
    if field.flag == false
      field.set_flag
      @flags_remaining -= 1

    elsif field.flag
      field.set_flag
      @flags_remaining += 1
    end

  end

  # reveals field and all adjacent field given there are no adjacent mines
  def show_field(coordinates)

    field = get_field(coordinates)
    unless field.shown
      field.show_field

      if field.sum_mines == 0
        field.find_adjacent_fields.each do |xy|
          field = get_field(xy)
          display_field(field.coordinates) unless field.mine == true
        end
      end
    end
  end

  # returns coordinates of all mines
  def mine_coords

    all_mines = []
    @board.flatten.each do |field|
      all_mines << field.coordinates if field.mine == true
    end

    all_mines
  end

  # returns coordinates of all flags
  def flag_coords

    all_flags = []
    @board.flatten.each do |field|
      all_flags << field.coordinates if field.flag == true
    end

    all_flags
  end

  # defines losing condition
  def lose?(coordinates)
    field = get_field(coordinates)
    field.mine
  end

  # defines victory condition
  def victory?
    all_flags = flag_coords
    @mine_coords.all { |mine| all_flags.include?(mine) }
  end

  # reveals all fields containing mines
  def reveal_mines

    @board.flatten.each do |field|
      if field.mine
        field.show_field
      end

    end
  end

  def render

    system "clear"
    output = "MINESWEEPER\n-----------\n#{@flags_remaining} Flags Remaining\n-----------\n"

    @board.each_with_index do |row, index|
      index == 0 ? output << "#{@size - index} | " : output << "#{@size - index}  | "

      row.each do |field|
        if field.shown == false && field.flag == false
          output << "O"
        elsif field.shown == false && field.flag == true
          output << "F"
        elsif field.shown == true && field.mine == true && field.flag == true
          output << "F"
        elsif field.shown == true && field.mine == true
          output << "M"
        elsif field.shown == true
          output << field.sum_mines.to_s
        end
      end

      output << "\n"

    end

    output << "    ___________\n"
    output << "    12345678910\n"
    print output
  end

end
