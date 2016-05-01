class Piece < ActiveRecord::Base
  # DB Relations
  belongs_to :game

  # Validations
end
