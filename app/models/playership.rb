class Playership < ActiveRecord::Base
  # DB Relations
  belongs_to :player
  belongs_to :game
end
