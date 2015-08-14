require 'field'

describe Field do
  let(:f){ Field.new([1,1], 8) }

  describe '#set_mine' do

    it 'sets field to contain a mine' do
      f.set_mine
      expect(f.mine).to eq(true)
    end

  end

  describe '#set_flag' do

    it 'sets flag from false to true' do
      f.set_flag
      expect(f.flag).to eq(true)
    end

    it 'sets flag from true to false' do
      f.set_flag
      f.set_flag
      expect(f.flag).to eq(false)
    end

  end

  describe '#show_field' do

    it 'sets @shown to true' do
      f.show_field
    end

  end

  describe '#find_adjacent_fields' do

    it 'returns the surrounding coordinates of a field in the corner' do
      expect(f.find_adjacent_fields).to eq([[1,2], [2,1], [2,2]])
    end

    it 'returns the surrounding coordinates of a field' do
      field = Field.new([3,3], 8)
      expect(field.find_adjacent_fields).to eq([[2,2], [2,3], [2,4], [3,2], [3,4], [4,2], [4,3], [4,4]])
    end

  end
end