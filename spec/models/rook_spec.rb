require 'rails_helper'

RSpec.describe Rook, type: :model do
  it "should have a valid factory" do
    rook = create(:rook)
    expect(rook).to be_valid
  end
end
