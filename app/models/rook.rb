class Rook < Piece
  # Still need support for castling

  def valid_move?(end_coord)
    # Basic checks
    return false unless valid_move_direction?(end_coord) && game.valid_coordinate?(end_coord)
    # Check move direction
    direction = get_move_direction(end_coord)
    return false if direction == :diagonal
    # Check obstruction
    return false if obstructed?(end_coord)

    true
  end
end
