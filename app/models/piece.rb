class Piece < ActiveRecord::Base
  # DB Relations
  belongs_to :game

  # Validations
  validates :color, presence: true, inclusion: { in: ['white', 'black'] }
  validates :x_pos, presence: true, numericality: { only_integer: true }
  validates :y_pos, presence: true, numericality: { only_integer: true }
  validates :captured, inclusion: { in: [true, false] }
  validates :game, presence: true
end
