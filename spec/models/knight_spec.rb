require 'rails_helper'

RSpec.describe Knight, type: :model do
  it "should have a valid factory" do
    knight = create(:knight)
    expect(knight).to be_valid
  end

  describe "#valid_move?" do

    let(:knight) { create(:knight, x_pos:4, y_pos:4) }

    it "should not allow the knight to move Horizontal" do
      expect(knight.valid_move?([1,4])).to eq false
    end

    it "should not allow the knight to move Vertical" do
      expect(knight.valid_move?([4,1])).to eq false
    end

    it "should not allow the knight to move Diagonal" do
      expect(knight.valid_move?([1,1])).to eq false
    end

    it "should allow knight to move only by a distance of 2 x 1" do
      expect(knight.valid_move?([3,2])).to eq true
      expect(knight.valid_move?([2,3])).to eq true
      expect(knight.valid_move?([3,1])).to eq false
    end
  end
end
