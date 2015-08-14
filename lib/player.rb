class Player

  def initialize(grid_size = 8)
    @grid_size = grid_size
  end

  def get_move

    puts 'Input either (1) to add/remove a flag, or (2) to clear a field.'

    input = gets.chomp.to_i
    until input == 1 || input == 2
      puts 'Please input a valid option.'
      input = gets.chomp.to_i
    end

    input
  end

  def get_coordinates

    puts 'Enter the field coordinates (ex. 1,1)'
    input = gets.chomp.split(',').map(&:to_i)

    until valid_coordinates(input)
      puts 'Please input valid coordinates.'
      input = gets.chomp.split(',').map(&:to_i)
    end

    input
  end

  def valid_coordinates(coordinates)

    coordinates.length == 2 && coordinates.all?{ |input| input >=1 && input <= @grid_size }
  end

end