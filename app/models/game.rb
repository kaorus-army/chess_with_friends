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

<<<<<<< HEAD
  def populate_game
    # populate black pieces at top
  
    (0..7).each do |n|
      pieces.create(type: "Pawn", color: "black", x_pos: n, y_pos: 6)
    end

    pieces.create(type: "Rook", color: "black", x_pos: 0, y_pos: 7)
    pieces.create(type: "Rook", color: "black", x_pos: 7, y_pos: 7)


    pieces.create(type: "Knight", color: "black", x_pos: 1, y_pos: 7)
    pieces.create(type: "Knight", color: "black", x_pos: 6, y_pos: 7)

    pieces.create(type: "Bishop", color: "black", x_pos: 2, y_pos: 7)
    pieces.create(type: "Bishop", color: "black", x_pos: 5, y_pos: 7)

    pieces.create(type: "Queen", color: "black", x_pos: 3, y_pos: 7)

    pieces.create(type: "King", color: "black", x_pos: 4, y_pos: 7)

    #populate white pieces at bottom
    (0..7).each do |n|
      pieces.create(type: "Pawn", color: "white", x_pos: n, y_pos: 1)
    end

    pieces.create(type: "Rook", color: "white", x_pos: 0, y_pos: 0)
    pieces.create(type: "Rook", color: "white", x_pos: 7, y_pos: 0)

    pieces.create(type: "Knight", color: "white", x_pos: 1, y_pos: 0)
    pieces.create(type: "Knight", color: "white", x_pos: 6, y_pos: 0)

    pieces.create(type: "Bishop", color: "white", x_pos: 2, y_pos: 0)
    pieces.create(type: "Bishop", color: "white", x_pos: 5, y_pos: 0)

    pieces.create(type: "Queen", color: "white", x_pos: 3, y_pos: 0)

    pieces.create(type: "King", color: "white", x_pos: 4, y_pos: 0)
  end

=======
  def valid_coordinate?(coord)
    end_x_pos = coord[0]
    end_y_pos = coord[1]

    (0..7).include?(end_x_pos) && (0..7).include?(end_y_pos)
  end
>>>>>>> 9dab9f9abb30bef669c299dd4363b131b7fab260

end
