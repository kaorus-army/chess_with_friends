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
end
