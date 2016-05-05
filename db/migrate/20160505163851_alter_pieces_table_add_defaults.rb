class AlterPiecesTableAddDefaults < ActiveRecord::Migration
  def change
    change_column :pieces, :x_pos, :integer, default: 0
    change_column :pieces, :y_pos, :integer, default: 0
    change_column :pieces, :color, :string, default: 'white'
    change_column :pieces, :captured, :boolean, default: false
  end
end
