class CreatePlayerships < ActiveRecord::Migration
  def change
    create_table :playerships do |t|
      t.belongs_to :player, index: true
      t.belongs_to :game, index: true

      t.timestamps null: false
    end
  end
end
