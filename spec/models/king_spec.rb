require 'rails_helper'

RSpec.describe King, type: :model do
  it "should have a valid factory" do
    king = create(:king)
    expect(king).to be_valid
  end

  describe "valid_move?" do

    let(:king) { create(:king, x_pos:5, y_pos:5) }

    it "should allow for only movement of one space " do
      expect(king.valid_move?([4,5])).to eq true
      expect(king.valid_move?([2,5])).to eq false
    end

    it "should allow king to move in any direction" do
      expect(king.valid_move?([4,5])).to eq true #left
      expect(king.valid_move?([6,5])).to eq true #right
      expect(king.valid_move?([5,4])).to eq true #up
      expect(king.valid_move?([5,6])).to eq true #down
      expect(king.valid_move?([4,4])).to eq true #up-left
      expect(king.valid_move?([6,4])).to eq true #up-left
      expect(king.valid_move?([4,6])).to eq true #down-left
      expect(king.valid_move?([6,6])).to eq true #down-right
    end
  end
end
