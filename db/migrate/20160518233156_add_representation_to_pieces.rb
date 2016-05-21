class AddRepresentationToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :representation, :string
  end
end
