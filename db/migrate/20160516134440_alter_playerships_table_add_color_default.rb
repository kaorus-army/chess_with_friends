class AlterPlayershipsTableAddColorDefault < ActiveRecord::Migration
  def change
    remove_column :playerships, :color
    add_column :playerships, :color, :string, { default: "white" }
  end
end
