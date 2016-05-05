require 'rails_helper'

RSpec.describe Knight, type: :model do
  it "should have a valid factory" do
    knight = create(:knight)
    expect(knight).to be_valid
  end
end
