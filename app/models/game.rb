class Game < ActiveRecord::Base
  # DB Relations
  has_many :playerships
  has_many :players, through: :playerships
  has_many :pieces

  # Validations
  validates :players, presence: true
  validates :moves_made, presence: true, numericality: { only_integer: true }
  validates :status, presence: true, inclusion: { in: ['start', 'in_progress', 'end'] }

  # Instance methods
  def uncaptured_pieces
    pieces = self.pieces.reject { |piece| piece.captured? }
    return pieces.empty? ? nil : pieces
  end
end
