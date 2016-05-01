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
end
