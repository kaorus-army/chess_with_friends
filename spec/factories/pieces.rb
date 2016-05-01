FactoryGirl.define do
  factory :piece do
    color("white")
    x_pos(0)
    y_pos(0)
    captured(false)
    game
  end

  factory :isolated_piece, class: Piece do
    color("white")
    x_pos(0)
    y_pos(0)
    captured(false)
  end
end
