require 'rails_helper'

RSpec.describe Game, type: :model do
  it "should have a valid factory" do
    game = create(:game)
    expect(game).to be_valid
  end

  it "should be invalid without a status" do
    game = build(:game, status: nil)
    expect(game).to_not be_valid
  end

  it "should be invalid without moves" do
    game = build(:game, moves_made: nil)
    expect(game).to_not be_valid
  end

  it "should be invalid without an associated player" do
    game = build(:isolated_game)
    expect(game).to_not be_valid
  end

  describe "#uncaptured_pieces" do

    let(:game) { create(:game) }
    let(:white_piece) { create(:piece, x_pos: 0, y_pos: 1, game: game) }
    let(:captured_white_piece) { create(:piece, x_pos: 1, y_pos: 1, game: game) }
    let(:black_piece) { create(:piece, x_pos: 4, y_pos: 4, game: game) }
    let(:captured_black_piece) { create(:piece, x_pos: 4, y_pos: 5, game: game) }

    it "should return [] if all pieces are captured" do
      new_game = create(:game)
      new_piece = create(:piece, captured: true, game: game)

      expect(new_game.uncaptured_pieces).to eq []
    end

    it "should return a list of uncaptured pieces" do
      expect(game.uncaptured_pieces.include?(white_piece)).to eq true
      expect(game.uncaptured_pieces.include?(black_piece)).to eq true
      expect(game.uncaptured_pieces.include?(captured_white_piece)).to eq true
      expect(game.uncaptured_pieces.include?(captured_black_piece)).to eq true
    end

  end

  describe "#populate" do

    let(:game) { create(:game) }

    it "should create 32 pieces" do
      game.populate
      expect(game.reload.pieces.count).to eq 32
    end

    it "should create 16 white pieces" do
      game.populate
      expect(game.pieces.where(color: "white").count).to eq 16
    end

    it "should create 16 black pieces" do
      game.populate
      expect(game.pieces.where(color: "black").count).to eq 16
    end

    it "should create 16 Pawns" do
      game.populate
      expect(game.pieces.where(type: "Pawn").count).to eq 16
    end

    it "should create 4 Rooks" do
      game.populate
      expect(game.pieces.where(type: "Rook").count).to eq 4
    end

    it "should create 4 Knights" do
      game.populate
      expect(game.pieces.where(type: "Knight").count).to eq 4
    end

    it "should create 4 Bishops" do
      game.populate
      expect(game.pieces.where(type: "Bishop").count).to eq 4
    end

    it "should create 2 Queens" do
      game.populate
      expect(game.pieces.where(type: "Queen").count).to eq 2
    end

    it "should create 2 Kings" do
      game.populate
      expect(game.pieces.where(type: "King").count).to eq 2
    end

    it "should place a white rook in the lower left-hand corner" do
      game.populate
      expect(game.pieces.where(type: "Rook", color: "white", x_pos: 0, y_pos: 0).count).to eq 1
    end

    it "should place a black knight in the top row, 2nd from the left" do
      game.populate
      expect(game.pieces.where(type: "Knight", color: "black", x_pos: 1, y_pos: 7).count).to eq 1
    end

    it "should place a white bishop in the bottom row, 3rd from the right" do
      game.populate
      expect(game.pieces.where(type: "Bishop", color: "white", x_pos: 5, y_pos: 0).count).to eq 1
    end

    it "should place a black queen in the top row, 4th from the left" do
      game.populate
      expect(game.pieces.where(type: "Queen", color: "black", x_pos: 3, y_pos: 7).count).to eq 1
    end


    it "should place a white king in the bottom row, 4th from the right" do
      game.populate
      expect(game.pieces.where(type: "King", color: "white", x_pos: 4, y_pos: 0).count).to eq 1
    end


    it "should place a black pawn in the 2nd row from the top, all the way to the right" do
      game.populate
      expect(game.pieces.where(type: "Pawn", color: "black", x_pos: 7, y_pos: 6).count).to eq 1
    end
end

  end # describe #uncaptured_pieces

  describe "#valid_coordinate?" do

    let(:game) { create(:game) }

    it "should return true for coordinates on the board" do
      expect(game.valid_coordinate?([0, 7])).to eq true
      expect(game.valid_coordinate?([3, 4])).to eq true
    end

    it "should return false for coordinates off the board" do
      expect(game.valid_coordinate?([-1, 2])).to eq false
      expect(game.valid_coordinate?([8, 9])).to eq false
    end

  end # describe #valid_coordinate?

