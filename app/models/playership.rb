class Playership < ActiveRecord::Base
  # DB Relations
  belongs_to :player
  belongs_to :game

  # Validations
  validates :color, presence: true, inclusion: { in: ['white', 'black'] }
end
