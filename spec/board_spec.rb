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

end