class AlterGamesTableAddNicknameColumn < ActiveRecord::Migration
  def change
    add_column :games, :nickname, :string, default: "Chess With Friends!"
  end
end
