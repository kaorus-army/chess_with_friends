class Piece < ActiveRecord::Base
  # DB Relations
  belongs_to :game

  # Validations
  validates :color, presence: true, inclusion: { in: ['white', 'black'] }
  validates :x_pos, presence: true, numericality: { only_integer: true }, inclusion: { in: (0..7).to_a }
  validates :y_pos, presence: true, numericality: { only_integer: true }, inclusion: { in: (0..7).to_a }
  validates :captured, inclusion: { in: [true, false] }
  validates :game, presence: true

  # Instance Methods

  # This method can vary with different (inherited) pieces
  # This method will change in future revisions
  def valid_move_direction?(end_coord)
    # Right now, only need to check if the move is horizontal,
    # vertical, or diagonal. Other pieces (e.g. Horse) will
    # contain varying logic.
    is_move_horizontal?(end_coord) || is_move_vertical?(end_coord) || is_move_diagonal?(end_coord)
  end

  # The caller of this method should have already checked if the move
  # is valid. This simply tells if the piece is obstructed along its
  # path.
  def obstructed?(end_coord)
    if is_move_horizontal?(end_coord)
      obstructed_horizontal?(end_coord)
    elsif is_move_vertical?(end_coord)
      obstructed_vertical?(end_coord)
    elsif is_move_diagonal?(end_coord)
      obstructed_diagonal?(end_coord)
    end
  end

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

    false
  end

  def obstructed_vertical?(end_coord)
    end_y_pos = end_coord[1]
    test_coordinates = []

    if self.y_pos < end_y_pos
      ((self.y_pos + 1)..(end_y_pos - 1)).each { |i| test_coordinates << [self.x_pos, i] }
    else
      ((end_y_pos + 1)..(self.y_pos - 1)).each { |i| test_coordinates << [self.x_pos, i] }
    end

    self.game.uncaptured_pieces.each { |piece| return true if test_coordinates.include?(piece.coordinate) }

    false
  end

  def obstructed_diagonal?(end_coord)
    end_x_pos = end_coord[0]
    end_y_pos = end_coord[1]
    test_coordinates = []
    spaces = (self.x_pos - end_x_pos).abs
    count = 1

    #up - left
    if self.x_pos > end_x_pos && self.y_pos > end_y_pos
      (spaces - 1).times do
        test_coordinates << [self.x_pos - count, self.y_pos - count]
        count = count + 1
      end

    #up - right
    elsif self.x_pos < end_x_pos && self.y_pos > end_y_pos
      (spaces - 1).times do
        test_coordinates << [self.x_pos + count, self.y_pos - count]
        count = count + 1
      end

    #down - left
    elsif self.x_pos > end_x_pos && self.y_pos < end_y_pos
      (spaces - 1).times do
        test_coordinates << [self.x_pos - count, self.y_pos + count]
        count = count + 1
      end

    #down - right
    else self.x_pos < end_x_pos && self.y_pos < end_y_pos
      (spaces - 1).times do
        test_coordinates << [self.x_pos + count, self.y_pos + count]
        count = count + 1
      end
    end

    self.game.uncaptured_pieces.each { |piece| return true if test_coordinates.include?(piece.coordinate) }

    false
  end

  def coordinate
    [x_pos, y_pos]
  end

  def is_move_horizontal?(end_coord)
    end_coord[1] == self.y_pos
  end

  def is_move_vertical?(end_coord)
    end_coord[0] == self.x_pos
  end

  def is_move_diagonal?(end_coord)
    available_diagonal_coordinates.include?(end_coord)
  end

  def available_diagonal_coordinates
    coordinates = []

    # Up & Right
    x_pos = self.x_pos + 1
    y_pos = self.y_pos - 1
    while x_pos <= 7 && y_pos >= 0 do
      coordinates << [x_pos, y_pos]
      x_pos += 1
      y_pos -= 1
    end
    # Up & Left
    x_pos = self.x_pos - 1
    y_pos = self.y_pos - 1
    while x_pos >= 0 && y_pos >= 0 do
      coordinates << [x_pos, y_pos]
      x_pos -= 1
      y_pos -= 1
    end
    # Down & Right
    x_pos = self.x_pos + 1
    y_pos = self.y_pos + 1
    while x_pos <= 7 && y_pos <= 7 do
      coordinates << [x_pos, y_pos]
      x_pos += 1
      y_pos += 1
    end
    # Up & Right
    x_pos = self.x_pos - 1
    y_pos = self.y_pos + 1
    while x_pos >= 0 && y_pos <= 7 do
      coordinates << [x_pos, y_pos]
      x_pos -= 1
      y_pos += 1
    end

    coordinates
  end
end
