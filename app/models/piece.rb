class Piece < ActiveRecord::Base
  # DB Relations
  belongs_to :game

  # Validations
  validates :color, presence: true, inclusion: { in: ['white', 'black'] }
  validates :x_pos, presence: true, numericality: { only_integer: true }, inclusion: { in: (0..9).to_a }
  validates :y_pos, presence: true, numericality: { only_integer: true }, inclusion: { in: (0..9).to_a }
  validates :captured, inclusion: { in: [true, false] }
  validates :game, presence: true

  # Instance Methods
  def is_obstructed_horizontal?(end_x_pos)
    # Get all coordinates between this piece's x_pos and the end_x_pos
    # Cycle through each uncaptured piece on the board
      # If any piece's coordinate matches one in the list, return true
    # Return false if nothing gets returned from the loop

    
  end

  def coordinate
    return [x_pos, y_pos]
  end
end
