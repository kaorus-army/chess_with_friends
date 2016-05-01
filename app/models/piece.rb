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
  def obstructed_horizontal?(end_coord)
    # Get all coordinates between this piece's x_pos and the end_x_pos
    # Cycle through each uncaptured piece on the board
      # If any piece's coordinate matches one in the list, return true
    # Return false if nothing gets returned from the loop
    end_x_pos = end_coord[0]
    test_coordinates = []

    if self.x_pos < end_x_pos
      ((self.x_pos + 1)..(end_x_pos - 1)).each { |i| test_coordinates << [i, self.y_pos] }
    else
      ((end_x_pos + 1)..(self.x_pos - 1)).each { |i| test_coordinates << [i, self.y_pos] }
    end

    self.game.uncaptured_pieces.each { |piece| return true if test_coordinates.include?(piece.coordinate) }

    return false
  end

  def coordinate
    return [x_pos, y_pos]
  end
end
