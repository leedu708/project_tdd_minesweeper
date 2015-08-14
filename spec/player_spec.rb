require 'player'

describe Player do

  let(:p){ Player.new }

  describe '#get_move' do

    it 'returns 1 if player inputs a 1' do
      allow(p).to receive(:gets).and_return("1\n")
      allow(p).to receive(:puts).and_return(nil)
      expect(p.get_move).to eq(1)
    end

    it 'returns 2 if player inputs a 1' do
      allow(p).to receive(:gets).and_return("2\n")
      allow(p).to receive(:puts).and_return(nil)
      expect(p.get_move).to eq(2)
    end

    # it 'prompts user to input a valid option if input is not a 1 or a 2'

  end

  describe '#get_coordinates' do

    it 'returns the coordinates given valid input' do
      allow(p).to receive(:gets).and_return('2,2')
      allow(p).to receive(:puts).and_return(nil)
      expect(p.get_coordinates).to eq([2,2])
    end

    # it 'prompts user to input valid coordinates if given invalid input'

  end

  describe '#valid_coordinates' do

    it 'returns true when given valid coordinates' do
      expect(p.valid_coordinates([2,2])).to eq(true)
    end

    it 'returns false when given an array larger than 2 elements' do
      expect(p.valid_coordinates([1,2,3])).to eq(false)
    end

    it 'returns false when coordinates are larger than the grid_size' do
      expect(p.valid_coordinates([10,10])).to eq(false)
    end

    it 'returns false when coordinates are less than 1' do
      expect(p.valid_coordinates([-1,-1])).to eq(false)
    end

  end

end