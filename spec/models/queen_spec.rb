require 'rails_helper'

RSpec.describe Queen, type: :model do
  it "should have a valid factory" do
    expect(create(:queen)).to be_valid
  end
end
