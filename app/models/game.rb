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
    pieces.where(captured: false)
  end

  def coordinate_conflict?(test_coords)
    uncaptured_pieces.each do |piece|
      return true if test_coords.include?(piece.coordinate)
    end

    false
  end

  def valid_coordinate?(coord)
    end_x_pos = coord[0]
    end_y_pos = coord[1]
    if (0..7).include?(end_x_pos) && (0..7).include?(end_y_pos)
      true
    else
      false
    end
  end

end
