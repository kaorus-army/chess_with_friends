require 'rails_helper'

RSpec.describe Piece, type: :model do
  it "should have a valid factory" do
    piece = create(:piece)
    expect(piece).to be_valid
  end

  it "should be invalid without a color" do
    piece = build(:piece, color: nil)
    expect(piece).to_not be_valid
  end

  it "should be invalid without an x position" do
    piece = build(:piece, x_pos: nil)
    expect(piece).to_not be_valid
  end

  it "should be invalid without a y position" do
    piece = build(:piece, y_pos: nil)
    expect(piece).to_not be_valid
  end

  it "should be invalid without a captured state" do
    piece = build(:piece, captured: nil)
    expect(piece).to_not be_valid
  end

  it "should belong to a game" do
    piece = build(:isolated_piece)
    expect(piece).to_not be_valid
  end

  describe "#obstructed_horizontal?" do

    before(:example) do
      @game = create(:game)
    end

    it "should return true if piece is obstructed to the left" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 1,
        captured: false
      })
      pawn2 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 1,
        captured: false
      })

      expect(pawn2.obstructed_horizontal?([0, 1])).to eq true
    end

    it "should return true if piece is obstructed to the right" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 1,
        captured: false
      })
      pawn2 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 1,
        captured: false
      })

      expect(pawn1.obstructed_horizontal?([4, 1])).to eq true
    end

    it "should return false if piece is not obstructed to the left" do
      pawn2 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 1,
        captured: false
      })

      expect(pawn2.obstructed_horizontal?([0, 1])).to eq false
    end

    it "should return true if piece is not obstructed to the right" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 1,
        captured: false
      })

      expect(pawn1.obstructed_horizontal?([4, 1])).to eq false
    end

  end # end describe obstructed_horizontal

  describe "#obstructed_vertical" do

    before(:example) do
      @game = create(:game)
    end

    it "should return true if piece is obstructed above" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 1,
        captured: false
      })
      pawn2 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 3,
        captured: false
      })

      expect(pawn2.obstructed_vertical?([1, 0])).to eq true
    end

    it "should return true if piece is obstructed below" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 1,
        captured: false
      })
      pawn2 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 3,
        captured: false
      })

      expect(pawn1.obstructed_vertical?([1, 4])).to eq true
    end

    it "should return false if piece is not obstructed above" do
      pawn2 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 3,
        captured: false
      })

      expect(pawn2.obstructed_vertical?([1, 0])).to eq false
    end

    it "should return true if piece is not obstructed below" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 1,
        captured: false
      })

      expect(pawn1.obstructed_vertical?([1, 4])).to eq false
    end

  end # end describe obstructed_vertical

  describe "#obstructed_diagonal?" do

    before(:example) do
      @game = create(:game)
    end

    #----Obstructed Moves--------#
    it "should return true if a piece is obstructed up-left" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 3,
        captured: false
      })
      pawn2 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 1,
        captured: false
      })
        expect(pawn1.obstructed_diagonal?([0,0])).to eq true
    end

    it "should return true if a piece is obstructed up-right" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 3,
        captured: false
      })
      pawn2 = @game.pieces.create({
        color: "white",
        x_pos: 5,
        y_pos: 1,
        captured: false
      })
        expect(pawn1.obstructed_diagonal?([6,0])).to eq true

    end

    it "should return true if a piece is obstructed down-left" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 3,
        captured: false
      })
      pawn2 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 5,
        captured: false
      })
        expect(pawn1.obstructed_diagonal?([0,6])).to eq true
    end

    it "should return true if a piece is obstructed down-right" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 3,
        captured: false
      })
      pawn2 = @game.pieces.create({
        color: "white",
        x_pos: 5,
        y_pos: 5,
        captured: false
      })
        expect(pawn1.obstructed_diagonal?([6,6])).to eq true
    end

    #----Unobstructed Moves--------#

    it "should return false if a piece is not obstructed up-left" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 3,
        captured: false
      })

      expect(pawn1.obstructed_diagonal?([0,0])).to eq false
    end

    it "should return false if a piece is not obstructed up-right" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 3,
        captured: false
      })

      expect(pawn1.obstructed_diagonal?([6,0])).to eq false
    end

    it "should return false if a piece is not obstructed down-left" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 3,
        captured: false
      })

      expect(pawn1.obstructed_diagonal?([0,6])).to eq false
    end

    it "should return false if a piece is not obstructed down-right" do
      pawn1 = @game.pieces.create({
        color: "white",
        x_pos: 3,
        y_pos: 3,
        captured: false
      })

      expect(pawn1.obstructed_diagonal?([6,6])).to eq false
    end

  end # end describe obstructed_diagonal?

end
