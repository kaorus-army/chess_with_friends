class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :color
      t.integer :x_pos
      t.integer :y_pos
      t.boolean :captured
      t.belongs_to :game, index: true

      t.timestamps null: false
    end
  end
end
