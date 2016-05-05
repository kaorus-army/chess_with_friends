require 'rails_helper'

RSpec.describe King, type: :model do
  it "should have a valid factory" do
    king = create(:king)
    expect(king).to be_valid
  end
end
