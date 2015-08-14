require 'minesweeper'

describe MineSweeper do

  describe '#initialize' do

    it 'creates a new 8x8 board with 10 mines by default' do
      expect(Board).to receive(:new).with(8, 10)
      MineSweeper.new
    end

    it 'can receive custom board sizes and mines' do
      expect(Board).to receive(:new).with(3, 5)
      MineSweeper.new(3, 5)
    end

    it 'creates a new player object' do
      expect(Player).to receive(:new)
      MineSweeper.new
    end

  end

end