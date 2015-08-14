require 'board'
require 'field'

describe Board do
  let(:board) { Board.new }
  let(:field) { board.get_field([1,1]) }

  describe '#initialize' do

    it 'properly initializes @flags_remaining to 10 by default' do
      expect(board.flags_remaining).to eq(10)
    end

  end

  describe '#init_board' do

    it 'fills the board with fields' do
      board.init_board
      expect(board.board.flatten.all?{ |field| field.is_a?(Field) }). to eq(true)
    end

    it 'creates an 8 by 8 board by default' do
      board.init_board
      expect(board.board.flatten.length).to eq(64)
    end

    context 'test adjacent mines on the board' do

      it 'returns 0 if there are no adjacent mines' do
        test = Board.new(3, 0)
        test.sum_mines
        expect(test.get_field([2,2]).adjacent_mines).to eq(0)
      end

      it 'returns 2 if there are two adjacent mines' do
        # ensures field without mine is adjacent to 2 fields containing mines
        test = Board.new(3, 0)
        test.get_field([2,1]).set_mine
        test.get_field([2,3]).set_mine
        test.sum_mines
        expect(test.get_field([2,2]).adjacent_mines).to eq(2)
      end

    end

  end

  describe '#render' do

    # testing render a bit off since it always clears the terminal
    it 'renders a blank board when just initialized' do
      expect{board.render}.to output(/O/).to_stdout
    end

    it 'renders a F for flag' do
      board.get_field([2,2]).set_flag
      expect{board.render}.to output(/F/).to_stdout
    end

    it 'renders a M for mine' do
      board.get_field([2,2]).set_mine
      board.get_field([2,2]).show_field
      expect{board.render}.to output(/M/).to_stdout
    end

  end

  describe '#get_field' do

    it 'finds a field object' do
      expect(board.get_field([1,1])).to be_a(Field)
    end

    it 'finds a field object by coordinates' do
      field = board.get_field([2,2])
      expect(field.coordinates).to eq([2,2])
    end

  end

  describe '#flag_field' do

    it 'flags a field with input coordinates' do
      board.flag_field([2,2])
      expect(board.get_field([2,2]).flag).to eq(true)
    end

    it 'decrements @flags_remaining when a flag is set' do
      board.flag_field([2,2])
      expect(board.flags_remaining).to eq(9)
    end

    it 'increments @flags_remaining when a flag is removed' do
      board.flag_field([2,2])
      board.flag_field([2,2])
      expect(board.flags_remaining).to eq(10)
    end

  end

  describe '#show_field' do

    it 'shows a field' do
      board.show_field([2,2])
      expect(board.get_field([2,2]).shown).to eq(true)
    end

  end

  describe '#mine_coords' do

    it 'returns coordinates of all mines set' do
      test = Board.new(3,0)
      test.get_field([2,2]).set_mine
      test.get_field([1,1]).set_mine
      test.get_field([3,3]).set_mine
      expect(test.mine_coords).to include([1,1], [2,2], [3,3])
    end

  end

  describe '#flag_coords' do

    it 'returns coordinates of all flags' do
      test = Board.new(3,0)
      test.get_field([2,2]).set_flag
      test.get_field([1,1]).set_flag
      test.get_field([3,3]).set_flag
      expect(test.flag_coords).to include([1,1], [2,2], [3,3])
    end

  end

  describe '#lose?' do

    it 'returns true if player choice is a mine' do
      test = Board.new(3,0)
      test.get_field([2,2]).set_mine
      expect(test.lose?([2,2])).to eq(true)
    end

    it 'returns false if player choice is not a mine' do
      test = Board.new(3,0)
      expect(test.lose?([2,2])).to eq(false)
    end

  end

  describe '#victory?' do

    it 'returns true if all_flags == mine_coords' do
      test = Board.new(3,0)
      test.get_field([1,1]).set_mine
      test.get_field([2,2]).set_mine
      test.get_field([3,3]).set_mine

      test.get_field([1,1]).set_flag
      test.get_field([2,2]).set_flag
      test.get_field([3,3]).set_flag
      expect(test.victory?).to eq(true)
    end

    it 'returns false if win condition is not met' do
      test = Board.new(3,0)
      test.get_field([1,1]).set_mine
      test.get_field([2,2]).set_flag
      expect(test.victory?).to eq(false)
    end

  end

end