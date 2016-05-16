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

  end # end describe obstructed_horizontal?

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

  end # end describe obstructed_vertical?

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

  describe "#valid_move_direction?" do

    before(:example) do
      @game = create(:game)
      @piece = @game.pieces.create({
          color: "white",
          x_pos: 3,
          y_pos: 3,
          captured: false
      })
    end

    it "should be true for horizontal moves" do
      expect(@piece.valid_move_direction?([0, 3])).to eq true
      expect(@piece.valid_move_direction?([5, 3])).to eq true
    end

    it "should be true for vertical moves" do
      expect(@piece.valid_move_direction?([3, 5])).to eq true
      expect(@piece.valid_move_direction?([3, 0])).to eq true
    end

    it "should be true for diagonal moves" do
      expect(@piece.valid_move_direction?([5, 1])).to eq true
      expect(@piece.valid_move_direction?([1, 5])).to eq true
      expect(@piece.valid_move_direction?([2, 2])).to eq true
      expect(@piece.valid_move_direction?([4, 4])).to eq true
    end

    it "should be false for all other moves" do
      expect(@piece.valid_move_direction?([4, 1])).to eq false
    end

  end # end describe can_move_to?

  describe "#obstructed?" do

    before(:example) do
      @game = create(:game)
      @piece1 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 1,
        captured: false
      })
      @piece2 = @game.pieces.create({
        color: "black",
        x_pos: 3,
        y_pos: 1,
        captured: false
      })
      @piece3 = @game.pieces.create({
        color: "white",
        x_pos: 1,
        y_pos: 3,
        captured: false
      })
    end

    it "should be true for obstructed moves horizontally" do
      expect(@piece1.obstructed?([4, 1])).to eq true
    end

    it "should be true for obstructed moves vertically" do
      expect(@piece1.obstructed?([1, 4])).to eq true
    end

    it "should be true for obstructed moves diagonally" do
      expect(@piece3.obstructed?([4, 0])).to eq true
    end

    it "should be false for non-obstructed moves" do
      expect(@piece1.obstructed?([4, 4])).to eq false
    end

  end # end describe obstructed?

  describe "#distance_from" do

    let(:game) { create(:game) }
    let(:pawn) { create(:pawn, game: game, x_pos: 1, y_pos: 1) }

    it "should give a valid distance for horiztonal moves" do
      expect(pawn.distance_from([3, 1], :horizontal)).to eq 2
    end

    it "should give a valid distance for vertical moves" do
      expect(pawn.distance_from([1, 5], :vertical)).to eq 4
    end

    it "should give a valid distance for diagonal moves" do
      expect(pawn.distance_from([4, 4], :diagonal)).to eq 3
    end

    it "should return nil for an invalid move direction" do
      expect(pawn.distance_from([3, 5], :invalid)).to eq nil
    end

  end # descibe #distance_from

  describe "#move_to" do

    let(:king) { create(:king, x_pos: 4, y_pos: 4, color:"white") }

    it "should retrun true when space is occupied" do
      blk_piece = king.game.pieces.create(x_pos: 3, y_pos: 4, color:"black")
      expect(king.move_to([3,4])).to eq true
    end

  end
end
