require 'rails_helper'

RSpec.describe Bishop, type: :model do
  it "should have a valid factory" do
    bishop = create(:bishop)
    expect(bishop).to be_valid
  end
end
