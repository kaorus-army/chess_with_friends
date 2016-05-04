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

  def drawboard

    board = [
      [0,1,0,1,0,1,0,1],
      [1,0,1,0,1,0,1,0],
      [0,1,0,1,0,1,0,1],
      [1,0,1,0,1,0,1,0],
      [0,1,0,1,0,1,0,1],
      [1,0,1,0,1,0,1,0],
      [0,1,0,1,0,1,0,1],
      [1,0,1,0,1,0,1,0]
    ]

    board.each do |row|
      row.each do |col|

        if col == 1
          puts "<div class = 'black_space'></div>"
        else
          puts "<div class = 'white_space'></div>"
        end
      end
    end

  end

end
