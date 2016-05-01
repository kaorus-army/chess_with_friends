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

  
end
