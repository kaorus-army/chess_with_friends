require 'rails_helper'

RSpec.describe Pawn, type: :model do
  it "should have a valid factory" do
    pawn = create(:pawn)
    expect(pawn).to be_valid
  end

  describe "#valid_move?" do

    context "when a black pawn moves" do

      let(:initial_black_pawn) { create(:pawn, color: "black", x_pos: 2, y_pos: 1) }
      let(:moved_black_pawn) { create(:pawn, color: "black", x_pos: 2, y_pos: 3, moves_made: 2) }

      it "should return true for a valid move" do
        # Opening move can be distance of 2
        expect(initial_black_pawn.valid_move?([2, 3])).to eq true
        # Opening move can be distance of 1
        expect(initial_black_pawn.valid_move?([2, 2])).to eq true
      end

      it "should return false for bad direction" do
        # Diagonal not allowed
        expect(initial_black_pawn.valid_move?([3, 2])).to eq false
        # Horizontal not allowed
        expect(moved_black_pawn.valid_move?([3, 3])).to eq false
      end

      it "should return false for bad distance" do
        expect(initial_black_pawn.valid_move?([2, 4])).to eq false
        expect(moved_black_pawn.valid_move?([2, 5])).to eq false
      end

      it "should return false for bad coordinate" do
        # Coordinate not on board
        expect(initial_black_pawn.valid_move?([8, 6])).to eq false
      end

      it "should return false for a wrong vector" do
        # Black pawns can only move "down"
        expect(moved_black_pawn.valid_move?([2, 2])).to eq false
      end

      it "should return false if pawn is obstructed" do
        game = create(:game)
        pawn = create(:pawn, color: "black", x_pos: 2, y_pos: 1, game: game)
        obstructing_piece = game.pieces.create(color: "black", x_pos: 2, y_pos: 2)

        expect(pawn.valid_move?([2, 3])).to eq false
      end

      it "should return false if it tries to move on itself" do
        expect(initial_black_pawn.valid_move?(initial_black_pawn.coordinate)).to eq false
      end

    end # context when black pawn

    context "when a white pawn moves" do

      # Most white piece tests capture the main behavior
      let(:white_pawn) { create(:pawn, x_pos: 4, y_pos: 4) }

      it "should return false for a wrong vector" do
        # White pawns can only move "up"
        expect(white_pawn.valid_move?([4, 5])).to eq false
      end

    end # context when white pawn

  end # describe #valid_move?
end
