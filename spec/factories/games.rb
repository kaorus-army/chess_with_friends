FactoryGirl.define do
  factory :game do
    after(:build) do |game|
      game.save(:validate => false)
      player = create(:player)
      player.playerships.create(game: game)
    end

    moves_made(0)
    status("start")
  end

  factory :isolated_game, class: Game do
    moves_made(0)
    status("start")
  end
end
