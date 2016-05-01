class AlterGamesTableRenameMovesToMovesMade < ActiveRecord::Migration
  def change
    rename_column(:games, :moves, :moves_made)
  end
end
