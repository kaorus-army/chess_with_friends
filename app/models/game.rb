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

  def populate
    # populate black pieces at top
  
    (0..7).each do |n|
      Pawn.create(game: self, color: "black", x_pos: n, y_pos: 6, representation: '&#9823;')
    end

    Rook.create(game: self, color: "black", x_pos: 0, y_pos: 7, representation: '&#9820;')
    Rook.create(game: self,  color: "black", x_pos: 7, y_pos: 7, representation: '&#9820;')


    Knight.create(game: self,  color: "black", x_pos: 1, y_pos: 7, representation: '&#9822;')
    Knight.create(game: self,  color: "black", x_pos: 6, y_pos: 7, representation: '&#9822;')

    Bishop.create(game: self,  color: "black", x_pos: 2, y_pos: 7, representation: '&#9821;')
    Bishop.create(game: self,  color: "black", x_pos: 5, y_pos: 7, representation:'&#9821;')

    Queen.create(game: self,  color: "black", x_pos: 3, y_pos: 7, representation: '&#9819;')

    King.create(game: self,  color: "black", x_pos: 4, y_pos: 7, representation: '&#9818;')

    #populate white pieces at bottom
    (0..7).each do |n|
      Pawn.create(game: self,  color: "white", x_pos: n, y_pos: 1, representation: '&#9817;')
    end

    Rook.create(game: self,  color: "white", x_pos: 0, y_pos: 0, representation: '&#9814;')
    Rook.create(game: self,  color: "white", x_pos: 7, y_pos: 0, representation: '&#9814;')

    Knight.create(game: self,  color: "white", x_pos: 1, y_pos: 0, representation: '&#9816;')
    Knight.create(game: self,  color: "white", x_pos: 6, y_pos: 0, representation: '&#9816;')

    Bishop.create(game: self,  color: "white", x_pos: 2, y_pos: 0, representation: '&#9815;')
    Bishop.create(game: self,  color: "white", x_pos: 5, y_pos: 0, representation: '&#9815;')

    Queen.create(game: self,  color: "white", x_pos: 3, y_pos: 0, representation: '&#9813;')

    King.create(game: self,  color: "white", x_pos: 4, y_pos: 0, representation: '&#9812;')
  end

  # def board_pieces(row, col)
  #   pieces.where(x_pos: row, y_pos: col).take
  # end

  def valid_coordinate?(coord)
    end_x_pos = coord[0]
    end_y_pos = coord[1]

    (0..7).include?(end_x_pos) && (0..7).include?(end_y_pos)
  end

end
