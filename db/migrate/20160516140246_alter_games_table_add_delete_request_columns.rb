class AlterGamesTableAddDeleteRequestColumns < ActiveRecord::Migration
  def change
    add_column :games, :delete_request_black, :boolean, { default: false }
    add_column :games, :delete_request_white, :boolean, { default: false }
  end
end
