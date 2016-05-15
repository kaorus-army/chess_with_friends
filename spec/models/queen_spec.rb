require 'rails_helper'

RSpec.describe Queen, type: :model do
  it "should have a valid factory" do
    expect(create(:queen)).to be_valid
  end

  describe "valid_move?" do

    let(:queen) { create(:queen, x_pos:5, y_pos:5) }

    it "should allow queen to move any number of spaces" do
      expect(queen.valid_move?([1,1])).to eq true
      expect(queen.valid_move?([5,3])).to eq true
      expect(queen.valid_move?([1,5])).to eq true
    end

    it "should allow queen to move in any direction" do
      expect(queen.valid_move?([4,5])).to eq true #left
      expect(queen.valid_move?([6,5])).to eq true #right
      expect(queen.valid_move?([5,4])).to eq true #up
      expect(queen.valid_move?([5,6])).to eq true #down
      expect(queen.valid_move?([4,4])).to eq true #up-left
      expect(queen.valid_move?([6,4])).to eq true #up-left
      expect(queen.valid_move?([4,6])).to eq true #down-left
      expect(queen.valid_move?([6,6])).to eq true #down-right
    end

    it "should be false if queen is obstructed" do
      obstructing_left = queen.game.pieces.create(x_pos: 2, y_pos: 5)
      expect(queen.valid_move?([1,5])).to eq false
      obstructing_up_left = queen.game.pieces.create(x_pos: 4, y_pos: 4)
      expect(queen.valid_move?([3,3])).to eq false
      obstructing_up = queen.game.pieces.create(x_pos: 5, y_pos: 4)
      expect(queen.valid_move?([5,2])).to eq false
      obstructing_up_right = queen.game.pieces.create(x_pos: 6, y_pos: 4)
      expect(queen.valid_move?([7,3])).to eq false
      obstructing_right = queen.game.pieces.create(x_pos: 6, y_pos: 5)
      expect(queen.valid_move?([7,5])).to eq false
      obstructing_down_right = queen.game.pieces.create(x_pos: 6, y_pos: 6)
      expect(queen.valid_move?([7,7])).to eq false
      obstructing_down = queen.game.pieces.create(x_pos: 5, y_pos: 6)
      expect(queen.valid_move?([5,7])).to eq false
      obstructing_down_left = queen.game.pieces.create(x_pos: 4, y_pos: 6)
      expect(queen.valid_move?([3,7])).to eq false
    end
  end
end
