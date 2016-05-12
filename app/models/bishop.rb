class Bishop < Piece

  def valid_move?(end_coord)
    # Check basic move direction && coordinate
    return false unless valid_move_direction?(end_coord) && game.valid_coordinate?(end_coord)
    # Check direction is diagonal
    direction = get_move_direction(end_coord)
    return false unless direction == :diagonal
    # Check obstruction
    return false if obstructed?(end_coord)

    true
  end

end
