require 'rails_helper'

RSpec.describe Queen, type: :model do
  it "should have a valid factory" do
    expect(create(:queen)).to be_valid
  end

  describe "valid_move?" do

    let(:queen) { create(:queen, x_pos:5, y_pos:5) }

    it "should allow queen to move any number of spaces" do
      expect(queen.valid_move?([1,1])).to eq true
      expect(queen.valid_move?([5,3])).to eq true
      expect(queen.valid_move?([1,5])).to eq true
    end

    it "should allow queen to move in any direction" do
      expect(queen.valid_move?([4,5])).to eq true #left
      expect(queen.valid_move?([6,5])).to eq true #right
      expect(queen.valid_move?([5,4])).to eq true #up
      expect(queen.valid_move?([5,6])).to eq true #down
      expect(queen.valid_move?([4,4])).to eq true #up-left
      expect(queen.valid_move?([6,4])).to eq true #up-left
      expect(queen.valid_move?([4,6])).to eq true #down-left
      expect(queen.valid_move?([6,6])).to eq true #down-right
    end
  end
end
