require 'rails_helper'

RSpec.describe Player, type: :model do
  it "should have a valid factory" do
    player = create(:player)
    expect(player).to be_valid
  end

  it "should be invalid without a username" do
    player = build(:player, username: nil)
    expect(player).to_not be_valid
  end
end
