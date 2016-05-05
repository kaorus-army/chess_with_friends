require 'rails_helper'

RSpec.describe Pawn, type: :model do
  it "should have a valid factory" do
    pawn = create(:pawn)
    expect(pawn).to be_valid
  end
end
