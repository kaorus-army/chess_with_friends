class Queen < Piece
  # - can move in any direction for unlimited distance
  def valid_move?(end_coord)
    # Basic checks
    return false unless game.valid_coordinate?(end_coord)
    # Check obstruction
    return false if obstructed?(end_coord)

    true
  end
end
