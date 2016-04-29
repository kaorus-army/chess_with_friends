class AlterGamesTableChangeBoardColumnToJson < ActiveRecord::Migration
  def change
    remove_column(:games, :board)
    add_column(:games, :board, :json)
  end
end
