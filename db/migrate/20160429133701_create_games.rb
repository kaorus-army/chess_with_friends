class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :status
      t.integer :moves
      t.text :board

      t.timestamps null: false
    end
  end
end
