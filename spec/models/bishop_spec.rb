require 'rails_helper'

RSpec.describe Bishop, type: :model do
  it "should have a valid factory" do
    bishop = create(:bishop)
    expect(bishop).to be_valid
  end

  describe "#valid_move?" do

    let(:bishop) { create(:bishop, x_pos: 4, y_pos: 4) }

    it "should be true for diagonal moves of any distance" do
      expect(bishop.valid_move?([5, 5])).to eq true
      expect(bishop.valid_move?([0, 0])).to eq true
    end

    it "should be false for horizontal moves" do
      expect(bishop.valid_move?([7, 4])).to eq false
    end

    it "should be false for vertical moves" do
      expect(bishop.valid_move?([4, 7])).to eq false
    end

    it "should be false for obstructed moves" do
      game = create(:game)
      obstructing_piece = create(:piece, x_pos: 3, y_pos: 2, game: game)
      obstructed_bishop = create(:bishop, x_pos: 2, y_pos: 3, game: game)

      expect(obstructed_bishop.valid_move?([4, 1])).to eq false
    end

    it "should be false for invalid coordinates" do
      expect(bishop.valid_move?([8, 8])).to eq false
    end

  end # describe #valid_move?
end
