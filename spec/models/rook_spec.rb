require 'rails_helper'

RSpec.describe Rook, type: :model do
  it "should have a valid factory" do
    rook = create(:rook)
    expect(rook).to be_valid
  end

  describe "#valid_move?" do

    let(:white_rook) { create(:rook, x_pos: 2, y_pos: 3) }

    it "should be true for a horizontal move of any distance" do
      expect(white_rook.valid_move?([3, 3])).to eq true
      expect(white_rook.valid_move?([7, 3])).to eq true
    end

    it "should be true for a vertical move of any distance" do
      expect(white_rook.valid_move?([2, 4])).to eq true
      expect(white_rook.valid_move?([2, 7])).to eq true
    end

    it "should be false for an obstructed horizontal move" do
      game = create(:game)
      obstructed_rook = create(:rook, x_pos: 1, y_pos: 1, game: game)
      obstructing_piece = game.pieces.create(x_pos: 3, y_pos: 1)

      expect(obstructed_rook.valid_move?([4, 1])).to eq false
    end

    it "should be false for an obstructed vertical move" do
      game = create(:game)
      obstructed_rook = create(:rook, x_pos: 1, y_pos: 1, game: game)
      obstructing_piece = game.pieces.create(x_pos: 1, y_pos: 3)

      expect(obstructed_rook.valid_move?([1, 4])).to eq false
    end

    it "should be false for a diagonal move" do
      expect(white_rook.valid_move?([0, 1])).to eq false
      expect(white_rook.valid_move?([3, 4])).to eq false
    end

    it "should be false for an invalid coordinate" do
      expect(white_rook.valid_move?([-1, 3])).to eq false
      expect(white_rook.valid_move?([2, 8])).to eq false
    end

  end # describe #valid_move?

end
