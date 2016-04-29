class AlterPlayershipsTableAddColorColumn < ActiveRecord::Migration
  def change
    add_column(:playerships, :color, :string)
  end
end
