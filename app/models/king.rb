class King < Piece

  def valid_move?(end_coord)

    return false unless valid_move_direction?(end_coord) && game.valid_coordinate?(coord)
    # Check distance
    direction = get_move_direction(end_coord)
    distance = distance_from(end_coord, direction)
    return false if distance != 1
    # Check obstruction
    return false if obstructed?(end_coord)

    true
  end
end
