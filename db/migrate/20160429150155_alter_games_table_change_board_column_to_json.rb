class AlterGamesTableRemoveBoardColumn < ActiveRecord::Migration
  def change
    remove_column(:games, :board)
  end
end
