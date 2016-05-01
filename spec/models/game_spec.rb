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

    before(:example) do
      @game = create(:game)
    end

    it "should return nil if all pieces are captured" do
      @game.pieces.create({
        color: "white",
        x_pos: 0,
        y_pos: 1,
        captured: true
      })
      @game.pieces.create({
        color: "black",
        x_pos: 4,
        y_pos: 4,
        captured: true
      })

      expect(@game.uncaptured_pieces).to eq nil
    end

    it "should return a list of uncaptured pieces" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 0,
        y_pos: 1,
        captured: false
      })
      pawn2 = @game.pieces.create({
        color: "black",
        x_pos: 4,
        y_pos: 4,
        captured: false
      })
      pawn3 = @game.pieces.create({
        color: "white",
        x_pos: 4,
        y_pos: 5,
        captured: true
      })

      expect(@game.uncaptured_pieces.include? pawn1).to eq true
      expect(@game.uncaptured_pieces.include? pawn2).to eq true
      expect(@game.uncaptured_pieces.include? pawn3).to eq false
    end

  end
end
