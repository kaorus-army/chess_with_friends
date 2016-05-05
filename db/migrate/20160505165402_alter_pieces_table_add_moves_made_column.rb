class AlterPiecesTableAddMovesMadeColumn < ActiveRecord::Migration
  def change
    add_column :pieces, :moves_made, :integer, default: 0
  end
end
