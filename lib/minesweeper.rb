require_relative 'player'
require_relative 'board'
require_relative 'field'

class MineSweeper

  def initialize(grid_size = 8, input_mines = 10)

    @board = Board.new(grid_size, input_mines)
    @player = Player.new(grid_size)

  end

  def init_game

    puts 'Welcome to TDD Minesweeper'

    loop do
      @board.render
      move = @player.get_move
      coordinates = @player.get_coordinates

      # set or remove flag if option 1, else show field
      move == 1 ? @board.flag_field(coordinates) : @board.show_field(coordinates)

      # end game if clearing field with a mine
      if move == 2 && @board.lose?(coordinates)
        game_over
        break
      end

      # end game if win conditions are met
      if @board.victory?
        victory
        break
      end

    end

  end

  def game_over
    @board.render
    puts "Oops, you have chosen a field with a mine"
    puts "GAME OVER!"
  end

  def victory
    @board.render
    puts "You have found all the mines!"
    puts "WINNER!!"
  end

end